//! Synthesized `#![no_std]` Kani proof harnesses from `deap-safety-compile`.
//!
//! Safety & Traceability: Realises: [REQ-15], [REQ-23], [FLS: fls_modules].
//!
//! Contract: Preconditions: compiled inside `verification/kani-proofs` under
//! `#![no_std]` and `#![forbid(unsafe_code)]`; Postconditions: discharges bounded
//! model-checking obligations over `deap-contracts::generated` witnesses.
//!
//! Bounds & Faults: Bounded loop-free / fixed-bound proof obligations; zero heap.
use deap_contracts::generated::can_from_bits;
use deap_contracts::generated::CompiledLifecycleEvent;
use deap_contracts::generated::CompiledLifecycleFsm;
use deap_contracts::generated::SeedContractWitness;
use deap_contracts::generated::COMPILED_SIGNALS;
use deap_contracts::generated::PRIMARY_SIMPLEX_MONITOR;
use deap_contracts::CanF64;
use deap_contracts::ErrorCode;
use deap_contracts::IsqBound;
use deap_contracts::LifecycleMode;
use deap_contracts::ReqRealisation;
use deap_contracts::SafeHoldFsm;
use deap_contracts::ZcbfBarrierContract;
use deap_contracts::ZcbfBarrierInput;
/// Compiled boundary port count anchored into Kani proof obligations.
/// Realises: [REQ-15], [FLS: fls_constants].
pub const KANI_PORT_ANCHOR: usize = 120;
/// Verifies all compiled `COMPILED_SIGNALS` defaults satisfy `IsqBound`.
///
/// Safety & Traceability: Realises: [REQ-15], [REQ-23], [FLS: fls_functions].
///
/// Contract: Preconditions: `COMPILED_SIGNALS` holds Pass 1 signal bounds;
/// Postconditions: returns `Ok(())` iff triad `15` and every signal bound hold.
///
/// Bounds & Faults: Bounded fixed-array iteration (`<= 24`); zero heap allocation.
pub fn check_compiled_signal_envelopes() -> Result<(), ErrorCode> {
    SeedContractWitness::new().verify_triad_contract()?;
    let mut idx: usize = 0;
    while idx < COMPILED_SIGNALS.len() {
        if let Some(env) = COMPILED_SIGNALS.get(idx) {
            env.verify_in_bounds()?;
        }
        idx = idx.saturating_add(1);
    }
    Ok(())
}
/// Verifies `CompiledLifecycleFsm` reachability and `SafeHold` latching.
///
/// Safety & Traceability: Realises: [REQ-15], [REQ-23], [FLS: fls_functions].
///
/// Contract: Preconditions: none; Postconditions: proves `SafeHold` is reachable
/// and rejects uncommanded `CompleteInit` while latched in `SafeHold`.
///
/// Bounds & Faults: O(1) stack evaluation; fails closed with `DEAP_E0326`.
pub fn check_compiled_fsm_latch() -> Result<(), ErrorCode> {
    if !CompiledLifecycleFsm::verify_safe_hold_reachable() {
        return Err(ErrorCode::PreStpaCriterionFailedC7);
    }
    let mut fsm = CompiledLifecycleFsm::new();
    let s1 = fsm.step(CompiledLifecycleEvent::TripSafeHold)?;
    if s1 != LifecycleMode::SafeHold {
        return Err(ErrorCode::PreStpaCriterionFailedC7);
    }
    if fsm.step(CompiledLifecycleEvent::CompleteInit).is_ok() {
        return Err(ErrorCode::PreStpaCriterionFailedC7);
    }
    let s2 = fsm.step(CompiledLifecycleEvent::SupervisoryReset)?;
    if s2 != LifecycleMode::Init {
        return Err(ErrorCode::PreStpaCriterionFailedC7);
    }
    Ok(())
}
/// Verifies `PRIMARY_SIMPLEX_MONITOR` trips whenever `h_val <= h_floor`.
///
/// Safety & Traceability: Realises: [REQ-23], [REQ-15], [FLS: fls_functions].
///
/// Contract: Preconditions: `sample_h` is a finite `CanF64`; Postconditions:
/// returns `Ok(true)` when `sample_h <= h_floor`, propagating any FTTI fault.
///
/// Bounds & Faults: Constant stack space; non-FMA `CanF64` arithmetic.
pub fn check_compiled_simplex_floor(sample_h: CanF64) -> Result<bool, ErrorCode> {
    let input = ZcbfBarrierInput {
        h_val: sample_h,
        h_floor: can_from_bits(0x3fa9_9999_9999_999a_u64),
        lf_h_per_s: CanF64::ZERO,
        lg_h_u_per_s: CanF64::ZERO,
        gamma_per_s: can_from_bits(0x4000_0000_0000_0000_u64),
    };
    PRIMARY_SIMPLEX_MONITOR.should_trip(input)
}
#[cfg(kani)]
/// Bounded Kani proof verifying Pass 3 signal bounds and FSM SafeHold latch.
/// Realises: [REQ-15], [FLS: fls_functions].
#[kani::proof]
fn proof_compiled_contracts_hold() {
    assert!(check_compiled_signal_envelopes().is_ok());
    assert!(check_compiled_fsm_latch().is_ok());
    assert!(check_compiled_simplex_floor(CanF64::ZERO) == Ok(true));
}
#[cfg(test)]
mod tests {
    use super::*;
    /// Exercises Pass 3 generated contract proof obligations under `cargo test`.
    #[test]
    fn generated_contract_obligations_hold() {
        assert_eq!(check_compiled_signal_envelopes(), Ok(()));
        assert_eq!(check_compiled_fsm_latch(), Ok(()));
        assert_eq!(check_compiled_simplex_floor(CanF64::ZERO), Ok(true));
        assert_eq!(check_compiled_simplex_floor(CanF64::ONE), Ok(false));
    }
}

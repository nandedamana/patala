(* Highly influenced by the official ITrees tutorial (Imp2Asm). *)

From patala Require Import BpfIsa.
From Stdlib Require Import String.

From ITree Require Import
  ITree
  ITreeFacts.

Local Open Scope string_scope.

Variant RegEvent : Type -> Type :=
  | GetReg (r : Register) : RegEvent u64
  | SetReg (r : Register) (v : u64) : RegEvent unit.

Definition var := string.

Variant MemEvent : Type -> Type :=
  | GetVar (x : var) : MemEvent u64
  | SetVar (x : var) (v : u64) : MemEvent unit.

Section denote.
  Import Monads.
  Import ExtLib.Structures.Monad.
  Import ITreeNotations.

  Context {E : Type -> Type}.
  Context {hasRegEvent : RegEvent -< E}.
  Context {hasMemEvent : MemEvent -< E}.

  Definition denote_alusrc32 (src : AluSource32) : itree E u32 :=
    match src with
    | ImmAluSource32 imm => Ret imm
    | RegAluSource32 r => Ret imm0_u32 (* TODO truncate: trigger (GetReg r) *)
    end.

  Definition denote_alusrc64 (src : AluSource64) : itree E u64 :=
    match src with
    | ImmAluSource64 imm => Ret imm
    | RegAluSource64 r => trigger (GetReg r)
    end.

  (* TODO FIXME match on op and act accordingly *)
  Definition denote_instr (i : Inst) : itree E unit :=
    match i with
    | AluInst32 op src dst =>
        srcden <- denote_alusrc32 src ;; trigger (SetReg dst (u32_to_u64 srcden))
    | AluInst64 op src dst =>
        srcden <- denote_alusrc64 src ;; trigger (SetReg dst srcden)
    end.
End denote.

Variant Register :=
  | R0                     (* return value and exit code *)
  | R1 | R2 | R3 | R4 | R5 (* funcall arguments *)
  | R6 | R7 | R8 | R9      (* callee-saved registers *)
  | R10.                   (* read-only frame pointer *)

(* Low-level; TODO REM? *)
Variant InstClass :=
  | LD
  | LDX
  | ST
  | STX
  | ALU
  | JMP
  | JMP32
  | ALU64.

(* Low-level; TODO REM? *)
Variant AluSrcType :=
  | K
  | X.

Variant AluOp :=
  | ADD
  | SUB
  | MUL
  | DIV
  | OR
  | AND
  | LSH
  | RSH
  | NEG
  | MOD
  | XOR
  | MOV
  | ARSH
  | END.

Variant ByteSwapType :=
  | TO_LE
  | TO_BE.

Variant JumpOp :=
  | JA
  | JEQ
  | JGT
  | JGE
  | JSET
  | JNE
  | JSGT
  | JSGE
  | CALL
  | EXIT
  | JLT
  | JLE
  | JSLT
  | JSLE.

Variant LoadStoreMode :=
  | IMM
  (* Legacy
  | ABS
  | IND
  *)
  | MEM
  | MEMSX.
  (* TODO
  | ATOMIC.
  *)

Variant LoadStoreSize :=
  | W
  | H
  | B
  | DW.

(* The actual ISA reuses the values for regular ADD, OR, AND, and XOR *)
Variant AtomicOp :=
  | ATOMIC_ADD
  | ATOMIC_OR
  | ATOMIC_AND
  | ATOMIC_XOR.

Variant ComplexAtomicOp :=
  | FETCH
  | XCHG
  | CMPXCHG.

(* -------------------------------------------------------------------------- *)

From Stdlib Require Import
  Lia
  ZArith.
Local Open Scope Z_scope.

(* TODO use the one from trirocq *)
Section uint.
  Variable SIZE : nat.
  Definition modulus := 2 ^ Z.of_nat SIZE.

  Definition uint := { x | 0 <= x < modulus }.
End uint.

Definition u32 := uint 32.
Definition u64 := uint 64.

Definition imm0_u32 : u32.
  exists 0. compute. split; easy.
Defined.

Definition imm0_u64 : u64.
  exists 0. compute. split; easy.
Defined.

Definition u32_to_u64 (u : u32) : u64.
  destruct u as [u uh].
  exists u.
  unfold modulus in *.
  lia.
Qed.

(* -------------------------------------------------------------------------- *)

Variant AluSource32 :=
  | ImmAluSource32 : u32 -> AluSource32
  | RegAluSource32 : Register -> AluSource32.

Variant AluSource64 :=
  | ImmAluSource64 : u64 -> AluSource64
  | RegAluSource64 : Register -> AluSource64.

(** This data type is a custom take on the eBPF instructions, residing
at a higher level compared to the official eBPF ISA documentation. The
official documentation seems to focus more on the binary encoding. *)

Variant Inst :=
  | AluInst32 : AluOp -> AluSource32 -> Register -> Inst
  | AluInst64 : AluOp -> AluSource64 -> Register -> Inst.
(* TODO *)

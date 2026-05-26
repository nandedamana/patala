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

Definition Immvalue := nat.

Variant AluSource :=
  | ImmAluSource : Immvalue -> AluSource
  | RegAluSource : Register -> AluSource.

(** This data type is a custom take on the eBPF instructions, residing
at a higher level compared to the official eBPF ISA documentation. The
official documentation seems to focus more on the binary encoding. *)

Variant Inst :=
  | AluInst32 : AluOp -> AluSource -> Register -> Inst
  | AluInst64 : AluOp -> AluSource -> Register -> Inst.
(* TODO *)

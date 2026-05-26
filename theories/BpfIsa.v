Variant Register :=
  | R0                     (* return value and exit code *)
  | R1 | R2 | R3 | R4 | R5 (* funcall arguments *)
  | R6 | R7 | R8 | R9      (* callee-saved registers *)
  | R10.                   (* read-only frame pointer *)

Variant InstClass :=
  | LD
  | LDX
  | ST
  | STX
  | ALU
  | JMP
  | JMP32
  | ALU64.

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
  | ABS
  | IND
  | MEM
  | ATOMIC.

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

Variant Inst :=
  | LoadInst : LoadStoreMode -> LoadStoreSize -> Inst. (* TODO src, dest *)
(* TODO *)

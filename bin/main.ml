open Patala

let () =
  let cls = Patala.Inst.LDX in
  match cls with
  | Patala.Inst.LDX -> print_endline "Hello, LDX!"
  | _ -> print_endline "Hello, OtherInst!"

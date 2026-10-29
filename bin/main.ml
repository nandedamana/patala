open Patala

let () =
  let cls = Patala.BpfIsa.LDX in
  match cls with
  | Patala.BpfIsa.LDX -> print_endline "Hello, LDX!"
  | _ -> print_endline "Hello, OtherInst!"

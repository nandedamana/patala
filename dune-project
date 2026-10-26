(lang dune 3.21)

(name patala)

(generate_opam_files true)

; TODO
;(source
; (github username/reponame))

(authors "Nandakumar Edamana <nandakumar@nandakumar.co.in>")

(maintainers "Nandakumar Edamana <nandakumar@nandakumar.co.in>")

;(license  TODO)

(package
 (name patala)
 (synopsis "An eBPF-targeting compiler")
 (description "A compiler that targets eBPF, an ISA to extend operating system kernels.")
 (depends ocaml)
 (tags
  ("ebpf" "bpf" "linux" "networking")))

; See the complete stanza docs at https://dune.readthedocs.io/en/stable/reference/dune-project/index.html

(* -------------------------------------------------------------------- *)
open EcSymbols
open EcDecl
open EcModules
open EcAlgebra

(* -------------------------------------------------------------------- *)
type theory = theory_item list

and theory_item =
  | Th_type      of (symbol * tydecl)
  | Th_operator  of (symbol * operator)
  | Th_axiom     of (symbol * axiom)
  | Th_modtype   of (symbol * module_sig)
  | Th_module    of module_expr
  | Th_theory    of (symbol * theory)
  | Th_export    of EcPath.path
  | Th_instance  of EcTypes.ty * tcinstance
  | Th_typeclass of symbol

and tcinstance =
  [ `Ring of ring | `Field of field | `General of EcPath.path ]

(* -------------------------------------------------------------------- *)
type ctheory = {
  cth_desc   : ctheory_desc;
  cth_struct : ctheory_struct;
}

and ctheory_desc =
  | CTh_struct of ctheory_struct
  | CTh_clone  of ctheory_clone

and ctheory_struct = ctheory_item list

and ctheory_item =
  | CTh_type      of (symbol * tydecl)
  | CTh_operator  of (symbol * operator)
  | CTh_axiom     of (symbol * axiom)
  | CTh_modtype   of (symbol * module_sig)
  | CTh_module    of module_expr
  | CTh_theory    of (symbol * ctheory)
  | CTh_export    of EcPath.path
  | CTh_instance  of EcTypes.ty * tcinstance
  | CTh_typeclass of symbol

and ctheory_clone = {
  cthc_base : EcPath.path;
  cthc_ext  : (EcIdent.t * ctheory_override) list;
}

and ctheory_override =
| CTHO_Type   of EcTypes.ty


(* -------------------------------------------------------------------- *)
val module_comps_of_module_sig_comps:
  module_sig_body -> module_item list

val module_expr_of_module_sig:
  EcIdent.t -> module_type -> module_sig -> mod_restr -> module_expr

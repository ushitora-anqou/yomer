let failwithf fmt = Format.kasprintf failwith fmt
let invalid_argf fmt = Format.kasprintf invalid_arg fmt

module Low_level = struct
  open Ctypes
  open Foreign

  type code = unit ptr
  type compile_context = unit ptr
  type match_data = unit ptr
  type match_context = unit ptr
  type general_context = unit ptr

  let code : code typ = ptr void
  let compile_context : compile_context typ = ptr void
  let match_data : match_data typ = ptr void
  let match_context : match_context typ = ptr void
  let general_context : general_context typ = ptr void
  let sptr_8 = string
  let size = size_t

  (*
    pcre2_code *pcre2_compile(
      PCRE2_SPTR pattern,
      PCRE2_SIZE length,
      uint32_t options,
      int *errorcode,
      PCRE2_SIZE *erroroffset,
      pcre2_compile_context *ccontext
    );
  *)
  let compile_8 =
    foreign "pcre2_compile_8"
      (sptr_8 @-> size @-> uint32_t @-> ptr int @-> ptr size
     @-> ptr compile_context
      @-> returning (ptr code))

  (*
    void pcre2_code_free(
      pcre2_code *code
    );
  *)
  let code_free = foreign "pcre2_code_free_8" (ptr code @-> returning void)

  (*
    int pcre2_match(
      const pcre2_code *code,
      PCRE2_SPTR subject,
      PCRE2_SIZE length,
      PCRE2_SIZE startoffset,
      uint32_t options,
      pcre2_match_data *match_data,
      pcre2_match_context *mcontext
    );
  *)
  let match_ =
    foreign "pcre2_match_8"
      (ptr code @-> sptr_8 @-> size @-> size @-> uint32_t @-> ptr match_data
     @-> ptr match_context @-> returning int)

  (*
    int pcre2_substitute(
      const pcre2_code *code,
      PCRE2_SPTR subject,
      PCRE2_SIZE length,
      PCRE2_SIZE startoffset,
      uint32_t options,
      pcre2_match_data *match_data,
      pcre2_match_context *mcontext,
      PCRE2_SPTR replacementz,
      PCRE2_SIZE rlength,
      PCRE2_UCHAR *outputbuffer,
      PCRE2_SIZE *outlengthptr
    );
  *)
  let substitute =
    foreign "pcre2_substitute_8"
      (ptr code @-> sptr_8 @-> size @-> size @-> uint32_t @-> ptr match_data
     @-> ptr match_context @-> sptr_8 @-> size @-> ptr uchar @-> ptr size
     @-> returning int)

  (*
    int pcre2_get_error_message(
      int errorcode,
      PCRE2_UCHAR *buffer,
      PCRE2_SIZE bufflen
    );
  *)
  let get_error_message_8 =
    foreign "pcre2_get_error_message_8"
      (int @-> ptr uchar @-> size @-> returning int)

  (*
    pcre2_match_data *pcre2_match_data_create_from_pattern(
      const pcre2_code *code,
      pcre2_general_context *gcontext
    );
  *)
  let match_data_create_from_pattern =
    foreign "pcre2_match_data_create_from_pattern_8"
      (ptr code @-> ptr general_context @-> returning (ptr match_data))

  (*
    void pcre2_match_data_free(
      pcre2_match_data *match_data
    );
  *)
  let match_data_free =
    foreign "pcre2_match_data_free_8" (ptr match_data @-> returning void)

  (*
    PCRE2_SIZE pcre2_get_match_data_size(
      pcre2_match_data *match_data
    );
  *)
  let get_match_data_size =
    foreign "pcre2_get_match_data_size_8" (ptr match_data @-> returning size)

  (*
    uint32_t pcre2_get_ovector_count(
      pcre2_match_data *match_data
    );
  *)
  let get_ovector_count =
    foreign "pcre2_get_ovector_count_8" (ptr match_data @-> returning uint32_t)

  (*
    PCRE2_SIZE *pcre2_get_ovector_pointer(
      pcre2_match_data *match_data
    );
  *)
  let get_ovector_pointer =
    foreign "pcre2_get_ovector_pointer_8"
      (ptr match_data @-> returning (ptr size))
end

let string_of_error_code errorcode =
  let open Ctypes in
  let buflen = 1024 in
  let buf = allocate_n uchar ~count:buflen in
  let length =
    Low_level.get_error_message_8 errorcode buf (Unsigned.Size_t.of_int buflen)
  in
  buf |> coerce (ptr uchar) (ptr char) |> string_from_ptr ~length

type cflag =
  [ `ANCHORED
  | `ALLOW_EMPTY_CLASS
  | `ALT_BSUX
  | `ALT_CIRCUMFLEX
  | `ALT_VERBNAMES
  | `AUTO_CALLOUT
  | `CASELESS
  | `DOLLAR_ENDONLY
  | `DOTALL
  | `DUPNAMES
  | `ENDANCHORED
  | `EXTENDED
  | `EXTENDED_MORE
  | `FIRSTLINE
  | `LITERAL
  | `MATCH_INVALID_UTF
  | `MATCH_UNSET_BACKREF
  | `MULTILINE
  | `NEVER_BACKSLASH_C
  | `NEVER_UCP
  | `NEVER_UTF
  | `NO_AUTO_CAPTURE
  | `NO_AUTO_POSSESS
  | `NO_DOTSTAR_ANCHOR
  | `NO_START_OPTIMIZE
  | `NO_UTF_CHECK
  | `UCP
  | `UNGREEDY
  | `USE_OFFSET_LIMIT
  | `UTF ]

let int_of_cflag : cflag -> int = function
  | `ANCHORED -> 0x80000000
  | `NO_UTF_CHECK -> 0x40000000
  | `ENDANCHORED -> 0x20000000
  | `ALLOW_EMPTY_CLASS -> 0x00000001
  | `ALT_BSUX -> 0x00000002
  | `AUTO_CALLOUT -> 0x00000004
  | `CASELESS -> 0x00000008
  | `DOLLAR_ENDONLY -> 0x00000010
  | `DOTALL -> 0x00000020
  | `DUPNAMES -> 0x00000040
  | `EXTENDED -> 0x00000080
  | `FIRSTLINE -> 0x00000100
  | `MATCH_UNSET_BACKREF -> 0x00000200
  | `MULTILINE -> 0x00000400
  | `NEVER_UCP -> 0x00000800
  | `NEVER_UTF -> 0x00001000
  | `NO_AUTO_CAPTURE -> 0x00002000
  | `NO_AUTO_POSSESS -> 0x00004000
  | `NO_DOTSTAR_ANCHOR -> 0x00008000
  | `NO_START_OPTIMIZE -> 0x00010000
  | `UCP -> 0x00020000
  | `UNGREEDY -> 0x00040000
  | `UTF -> 0x00080000
  | `NEVER_BACKSLASH_C -> 0x00100000
  | `ALT_CIRCUMFLEX -> 0x00200000
  | `ALT_VERBNAMES -> 0x00400000
  | `USE_OFFSET_LIMIT -> 0x00800000
  | `EXTENDED_MORE -> 0x01000000
  | `LITERAL -> 0x02000000
  | `MATCH_INVALID_UTF -> 0x04000000

let cflags flags = List.fold_left (fun acc f -> acc lor int_of_cflag f) 0 flags

type regexp = Low_level.code Ctypes_static.ptr

let regexp ?(flags = []) ptn : regexp =
  let open Ctypes in
  let length = String.length ptn |> Unsigned.Size_t.of_int in
  let options = cflags flags |> Unsigned.UInt32.of_int in
  let errorcode = allocate int 0 in
  let erroroffset = allocate Low_level.size (Unsigned.Size_t.of_int 0) in
  let ccontext = coerce (ptr void) (ptr Low_level.match_context) null in
  let code =
    Low_level.compile_8 ptn length options errorcode erroroffset ccontext
  in
  (if code = coerce (ptr void) (ptr Low_level.code) null then
     let err_msg = string_of_error_code !@errorcode in
     let offset = Unsigned.Size_t.to_int !@erroroffset in
     invalid_argf "%s: compilation error at offset %d: %s" __FUNCTION__ offset
       err_msg);
  Gc.finalise Low_level.code_free code;
  code

type substrings = {
  match_data : Low_level.match_data Ctypes.ptr; (* Retain this not to free it *)
  ovector : Unsigned.size_t Ctypes.carray;
  num_substrings : int;
  subject : string;
}

let get_substring_ofs ss i =
  let open Ctypes in
  let start = CArray.get ss.ovector (i * 2) |> Unsigned.Size_t.to_int in
  if start < 0 then raise Not_found
  else
    let end_ = CArray.get ss.ovector ((i * 2) + 1) |> Unsigned.Size_t.to_int in
    (start, end_)

let get_substrings ({ num_substrings; subject; _ } as ss) =
  Array.init num_substrings @@ fun i ->
  match get_substring_ofs ss i with
  | exception Not_found -> ""
  | start, end_ -> String.sub subject start (end_ - start)

let exec ~rex:code ?pos subject =
  let open Ctypes in
  let length = subject |> String.length |> Unsigned.Size_t.of_int in
  let options = Unsigned.UInt32.of_int 0 in
  let startoffset = pos |> Option.value ~default:0 in
  let gcontext = coerce (ptr void) (ptr Low_level.general_context) null in
  let match_data = Low_level.match_data_create_from_pattern code gcontext in
  Gc.finalise Low_level.match_data_free match_data;
  let mcontext = coerce (ptr void) (ptr Low_level.match_context) null in
  match
    Low_level.match_ code subject length
      (Unsigned.Size_t.of_int startoffset)
      options match_data mcontext
  with
  | -1 (* PCRE2_ERROR_NOMATCH *) -> raise Not_found
  | c when c < 0 -> failwithf "%s: unexpected error: %d" __FUNCTION__ c
  | _ ->
      let num_substrings =
        Low_level.get_ovector_count match_data |> Unsigned.UInt32.to_int
      in
      let ovector = Low_level.get_ovector_pointer match_data in
      let ovector = CArray.from_ptr ovector (2 * num_substrings) in
      { match_data; ovector; num_substrings; subject }

let exec_all ~rex subject =
  let open Ctypes in
  let get_offset ss = CArray.get ss.ovector 1 |> Unsigned.Size_t.to_int in
  let substrings = exec ~rex subject in
  let rec loop pos acc =
    match
      if pos = String.length subject then None
      else
        match exec ~rex ~pos subject with
        | exception Not_found -> None
        | substrings ->
            let start = get_offset substrings in
            Some (start, substrings)
    with
    | None -> List.rev acc
    | Some (pos, substrings) ->
        Printf.eprintf "pos: %d %d\n" pos (String.length subject);
        loop pos (substrings :: acc)
  in
  loop (get_offset substrings) [ substrings ] |> Array.of_list

let substitute_substrings_first ~rex ~subst subject =
  match exec ~rex subject with
  | exception Not_found -> subject
  | ss ->
      let replacement = subst ss in
      let start, end_ = get_substring_ofs ss 0 in
      let buf = Buffer.create (String.length subject) in
      Buffer.add_substring buf subject 0 start;
      Buffer.add_string buf replacement;
      Buffer.add_substring buf subject end_ (String.length subject - end_);
      Buffer.contents buf

let substitute_substrings ~rex ~subst subject =
  let buf = Buffer.create (String.length subject) in
  let rec loop pos =
    match exec ~rex ~pos subject with
    | exception Not_found ->
        Buffer.add_substring buf subject pos (String.length subject - pos)
    | ss ->
        let replacement = subst ss in
        let start, end_ = get_substring_ofs ss 0 in
        Buffer.add_substring buf subject pos (start - pos);
        Buffer.add_string buf replacement;
        loop end_
  in
  loop 0;
  Buffer.contents buf

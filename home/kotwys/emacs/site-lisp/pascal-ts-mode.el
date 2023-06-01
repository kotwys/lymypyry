(require 'treesit)

(defvar pascal--treesit-keywords
  '((kProgram) (kLibrary) (kUnit) (kUses)
    (kBegin) (kEnd) (kAsm)
    (kVar) (kThreadvar) (kConst) (kResourcestring) (kConstref) (kOut) (kType)
;;     (kLabel) (kExports)
;;     (kAbsolute)
    (kProperty) (kRead) (kWrite) (kImplements) (kDefault) (kNodefault)
;;     (kStored) (kIndex)
    (kClass) (kInterface) (kObject) (kRecord) (kObjcclass) (kObjccategory)
    (kObjcprotocol) (kArray) (kFile) (kString) (kSet) (kOf) (kHelper) (kPacked)
;;     (kGeneric) (kSpecialize)
    (kFunction) (kProcedure) (kConstructor) (kDestructor) (kOperator)
;;     (kReference)
    (kInterface) (kImplementation) (kInitialization) (kFinalization)
    (kPublished) (kPublic) (kProtected) (kPrivate) (kStrict) (kRequired)
;;     (kOptional)
;;     (kForward)
    (kStatic) (kVirtual) (kAbstract) (kSealed) (kDynamic) (kOverride)
    (kOverload) (kReintroduce) (kInherited) (kInline)
;;     (kStdcall) (kCdecl) (kCppdecl) (kPascal) (kRegister) (kMwpascal)
;;     (kExternal) (kName) (kMessage) (kDeprecated) (kExperimental)
;;     (kPlatform) (kUnimplemented) (kCvar) (kExport) (kFar) (kNear)
;;     (kSafecall) (kAssembler) (kNostackframe) (kInterrupt) (kNoreturn)
;;     (kIocheck) (kLocal) (kHardfloat) (kSoftfloat) (kMs_abi_default)
;;     (kMs_abi_cdecl) (kSaveregisters) (kSysv_abi_default) (kSysv_abi_cdecl)
;;     (kVectorcall) (kVarargs) (kWinapi) (kAlias) (kDelayed)
    (kFor) (kTo) (kDownto) (kIf) (kThen) (kElse) (kDo) (kWhile) (kRepeat)
    (kUntil) (kTry) (kExcept) (kFinally) (kRaise) (kOn) (kCase)
    (kWith) (kGoto) (kIs) (kAs) (kIn)
    ;; Technically operators, but fontified as operators
    (kOr) (kXor) (kDiv) (kMod) (kAnd) (kShl) (kShr) (kNot)))

(defvar pascal-ts-mode-indent-offset 2)

(defvar pascal--treesit-operators
  '((kEq) (kAdd) (kSub) (kMul) (kFdiv) (kAssign) (kAssignAdd) (kAssignSub)
    (kAssignMul) (kAssignDiv) (kLt) (kLte) (kGt) (kGte) (kNeq) (kAt)
    (kHat)))

(defvar pascal--treesit-settings
  (treesit-font-lock-rules
   :feature 'comment
   :language 'pascal
   '((comment) @font-lock-comment-face)

   :feature 'preprocessor
   :language 'pascal
   '((pp) @font-lock-preprocessor-face)

   :feature 'string
   :language 'pascal
   '((literalString) @font-lock-string-face)
   
   :feature 'number
   :language 'pascal
   '((literalNumber) @font-lock-number-face)
   
   :feature 'keyword
   :language 'pascal
   `([,@pascal--treesit-keywords] @font-lock-keyword-face
     ;; PascalABC.NET in-place variable declaration
     (assignment lhs: ((identifier) @font-lock-keyword-face
                       (:match "^[vV][aA][rR]$"
                               @font-lock-keyword-face)))
     (ERROR ((identifier) @font-lock-keyword-face
             (:match "^[vV][aA][rR]$"
                     @font-lock-keyword-face)))
     ;; Break/Continue statements
     (statement ((identifier) @font-lock-keyword-face
                 (:match "^[bB][rR][eE][aA][kK]$"
                         @font-lock-keyword-face)))
     (statement ((identifier) @font-lock-keyword-face
                 (:match "^[cC][oO][nN][tT][iI][nN][uU][eE]$"
                         @font-lock-keyword-face))))

   :feature 'definition-type
   :language 'pascal
   '((declType name: (identifier) @font-lock-type-face)
     (declType name: (genericTpl entity: (identifier) @font-lock-type-face)))

   :feature 'definition-function
   :language 'pascal
   '((declProc name: (identifier) @font-lock-function-name-face)
     (declProc name: (genericTpl entity: (identifier)
                                 @font-lock-function-name-face))
     (declProc name: (genericDot rhs: (identifier)
                                 @font-lock-function-name-face))
     (declProc name:
               (genericDot rhs:
                           (genericTpl entity: (identifier)
                                       @font-lock-function-name-face))))

   :feature 'definition-property
   :language 'pascal
   '((declProp name: (identifier) @font-lock-property-name-face))

   :feature 'definition-argument
   :language 'pascal
   '((declArg name: (identifier) @font-lock-variable-name-face))

   :feature 'definition-variable
   :language 'pascal
   '((declVar name: (identifier) @font-lock-variable-name-face)
     (declField name: (identifier) @font-lock-property-name-face)
     (declConst name: (identifier) @font-lock-constant-face)
     (declEnumValue name: (identifier) @font-lock-constant-face))

   :feature 'operator
   :language 'pascal
   `([,@pascal--treesit-operators] @font-lock-operator-face)

   :feature 'genericarg
   :language 'pascal
   '((genericArg name: (identifier) @font-lock-type-face)
     (genericArg type: (typeref) @font-lock-type-face))

   :feature 'genericdot
   :language 'pascal
   '((genericDot (identifier) @font-lock-type-face)
     (genericDot (genericTpl entity: (identifier) @font-lock-type-face)))

   :feature 'exception
   :language 'pascal
   '((exceptionHandler variable: (identifier) @font-lock-variable-name-face))

   :feature 'type
   :language 'pascal
   '((typeref) @font-lock-type-face)

   :feature 'label
   :language 'pascal
   '([(caseLabel) (label)] @font-lock-constant-face)

   :feature 'keyword-control-flow
   :language 'pascal

   :feature 'function
   :language 'pascal
   '((exprCall entity: (identifier) @font-lock-function-call-face)
     (exprCall entity: (exprTpl entity: (identifier)
                                @font-lock-function-call-face))
     (exprCall entity: (exprDot rhs: (identifier)
                                @font-lock-function-call-face))
     (exprCall entity: (exprDot rhs:
                                (exprTpl entity: (identifier)
                                         @font-lock-function-call-face)))
     (statement (identifier) @font-lock-function-call-face)
     (statement (exprDot rhs: (identifier)
                         @font-lock-function-call-face))
     (statement (exprTpl entity: (identifier)
                         @font-lock-function-call-face))
     (statement (exprDot rhs:
                         (exprTpl entity: (identifier)
                                  @font-lock-function-call-face))))

   :feature 'module-name
   :language 'pascal
   '((moduleName (identifier) @font-lock-variable-name-face))

   :feature 'constant
   :language 'pascal
   '([(kTrue) (kFalse) (kNil)] @font-lock-constant-face)

   :feature 'bracket
   :language 'pascal
   '(["(" ")" "[" "]"] @font-lock-bracket-face)

   :feature 'delimiter
   :language 'pascal
   '([";" "," ":" ".."] @font-lock-delimiter-face)))

(defvar pascal--treesit-indent-rules
  `((pascal
     ((node-is ")") parent-bol 0)
     ((node-is "]") parent-bol 0)
     ((node-is "kEnd") parent-bol 0)
     ((parent-is "block") parent-bol pascal-ts-mode-indent-offset)
     ((parent-is "declArgs") parent-bol pascal-ts-mode-indent-offset)
     ((or (parent-is "declVars")
          (parent-is "declTypes")
          (parent-is "declConsts"))
      parent-bol pascal-ts-mode-indent-offset)
     ((or (parent-is "interface")
          (parent-is "implementation")
          (parent-is "initialization")
          (parent-is "finalization"))
      parent-bol pascal-ts-mode-indent-offset)
     ((parent-is "defProc") parent-bol 0)
     ((or (parent-is "declClass") (parent-is "declIntf"))
      parent-bol pascal-ts-mode-indent-offset)
     ((and (or (parent-is "if") (parent-is "for") (parent-is "while"))
           (not (node-is "block")))
      parent-bol pascal-ts-mode-indent-offset)
     ((parent-is "statement") parent-bol pascal-ts-mode-indent-offset)
     ((node-is "kExcept") parent-bol 0)
     ((node-is "kElse") parent-bol 0)
     ((parent-is "exceptionHandler") parent-bol pascal-ts-mode-indent-offset)
     ((parent-is "try") parent-bol pascal-ts-mode-indent-offset)
     ((and (node-is "statements") (parent-is "repeat"))
      parent-bol pascal-ts-mode-indent-offset)
     ((parent-is "exprCall") parent-bol pascal-ts-mode-indent-offset)
     ((parent-is "case") parent-bol pascal-ts-mode-indent-offset))))

(defvar pascal--electric-pairs
  '((?' . ?')))

(define-derived-mode pascal-ts-mode prog-mode "Pascal"
  "Custom major mode for Pascal using tree-sitter grammar."
  (when (treesit-ready-p 'pascal)
    (treesit-parser-create 'pascal)
    (setq-local comment-start "// ")
    (setq-local comment-end "")
    (setq-local indent-tabs-mode nil)
    (setq-local electric-pair-pairs (append electric-pair-pairs
                                            pascal--electric-pairs))
    (setq-local treesit-font-lock-settings pascal--treesit-settings)
    (setq-local treesit-simple-indent-rules pascal--treesit-indent-rules)
    (setq-local treesit-font-lock-feature-list
                '((comment preprocessor definition-type definition-function
                   definition-variable definition-argument definition-property)
                  (keyword label string type)
                  (constant number genericarg genericdot exception module-name)
                  (bracket delimiter function operator)))
    (treesit-major-mode-setup)
    (add-to-list 'auto-mode-alist '("\\.pas\\'" . pascal-ts-mode))))

(provide 'pascal-ts-mode)

# Change Log (Functional Changes)
## [1.0.27]
### Changes
* Added `uvm_sequence` functions snippet.
* Updated the main UVM phase snippet definition with proper objection related `uvm_info` macros.
* Added whitespace guide snippet aligned for `$sformatf()`.
* Added `c_` and `if_` to variable naming conventions to represent combinatorical wires and interfaces. (Design Naming Convention)
### Bugfixes
* Added missing `extensionKind` to package.json thus enabled remote install for SSH development.
* Added indent pattern for `(local|protected|static) virtual` functions and tasks.

## [1.0.26] Snippet reorganization: Coronavirus edition
### Changes
* Reworked UVM related snippets to be more convenient.
    * Parametrized UVM class snippets (eg.: `uvm_component_with_parameters`) will construct a proper parameter list for the typedef and the factory registration macro. The regexp transformation is not failsafe, but works well with `type` and `parameter` definitions. (eg.: `class x #(type T, parameter w = 3);`)
    * UVM sequence item related `do_` function snippets received an overhaul. (eg.: `uvm_sequence_item_do_compare`, `uvm_sequence_item_convert2string`, `uvm_sequence_item_do_print`, etc.) Instead of user constructed placeholders, they contain examples for placeholders via comments. Their structures are also unified.
    * The `uvm_info` macro snippet received a conditional placeholder for the verbosity setting.
    * The `uvm_error`, `uvm_fatal`, `uvm_info` and `uvm_warning` macro snippet received various conditional placeholder options for the ID field.
    * Added snippet for uvm_sequence derived classes with defined callback stubs and quick reference. (eg.: `uvm_sequence`)
    * UVM Phase snippets received a proper context parameter, but alas VSCode ignores it alltogether.
* Fixed `sv_class` and UVM class snippets to contain the same NaturalDocs group headers. (Variables, Constraints, Functions)
* Added snippets for some system tasks and functions; mostly because of the common use or the bogus parameter list. (eg: `$cast`, `$sformatf`, `$timeformat`, etc.)
* Added snippet support for the external and normal constraint blocks of SystemVerilog. (eg.: `sv_extern_constraint`, `sv_constraint_block`)
* Added snippet support for the covergroup, coverpoint and cross coverage blocks; also added snippets for their appropriate option and type_option structures. (eg.: `sv_covergroup`, `sv_covergroup_options`, `sv_covercross`, etc.)

### Bugfixes
* A few minor syntax fixes.

## [1.0.25]
### Changes
* Added snippet support for always block and design type variable names, also added parameter_parens construct.
* UVM phase function/task snippets follow the rule of `(uvm_)(extern_)?(phase)(<phase_name>)` now. (eg.: `uvm_extern_phase_build` or `uvm_phase_build`) Somehow it worked differently on Windows, Linux and MacOS with the previous definition. (Makes more sense to me to get the desired snippet via pressing `UPBU` or `UXPBU`.)

### Bugfixes
* Fixed `[(b[1].size()]` type scoping error where `.size()` was treated as an instantiation parameter.
* `define` folding mark removed. Might be a strange legacy from the past?
* Removed case independency from the do and while keywords. A full refactor of case independent flag might be required.
* Added proper scope support for multiple uvm_analysis_imp-s (macro defined extended names).


## [1.0.24]
### Changes
Language definition overhaul:
* Fixed and added proper support (autocomplete, stray checking, etc.) for all three kinds of paranthesis (Curly, Square, Round).
* UVM types and enum values received a major overhaul.
* Refactored the typedef scoping rules to have more flexibility regarding unpacked vectorized typedefs.
* Proper support of unbound expressions via `$`.
* Added snippets for factory overrides (`uvm_factory_inst_override`, `uvm_factory_type_override`).

### Bugfixes
* Folding markers end bug fixed; it consumed the rest of the file after the last fold.
* Component factory instantiation snippet was missing a `)`.

## [1.0.22]
### Changes
Minor snippet additions:
* Cleared up `uvm_config_db_get_guarded` snippet to be more user friendly.
* Added UVM Factory instantiation snippets. (`uvm_object_factory_instantiation`, `uvm_component_factory_instantiation`)
* Added UVM objection snippet (`uvm_objection_block`) to be available in task contexts.

## [1.0.20]
### Changes
* Changed sv_guard snippet to automatically use uppercase defines with `.` replaced to `_`.
* Changed the SV module and interface container snippets to default the name to the file name.
* Changed the SV module and interface snippets to point out proper `package_import_declaration` placement. By importing packages here, the package contents are available even in the parameter and port list and the import does not happen in the compilation unit/global namespace, thus avoiding confusions and overrides in various simulators. (See SV-LRM-2017: Syntax23-1 for more details.)
* Changed the SV function and task snippets to default the class scope to the file name.
* Changed the UVM phase snippets to default the class scope to the file name.

### Bugfixes
* Fixed reindent feature to ignore the `disable fork` and `wait fork` statements in the indentation increase.

## [1.0.19]
### Changes
* Changed the `sv_function` and `sv_task` snippet to have the class resolution operator `::` in a separate scope.

## [1.0.18]
### Bugfixes
* Import-Export keyword and related construct refactorization. (To support multiple imported items and entity name scopes in modules and interfaces.)
* Various UVM snippet related fixes and improvements.

## [1.0.15]
### Bugfixes
* Changed: endtask [: [class_scope] task_identifier] -> endtask [: task_identifier] Changed: endfunction  [: [class_scope] task_identifier] -> endfunction [: function_identifier] in snippets. Reason: class scope at the end of tasks and functions compile in ModelSim/QuestaSim but fails with more strict compiler implementations.
* Fixed various snippet issues.

## [1.0.14]
### Bugfixes
* Fixed reindent issue for virtual and pure virtual functions and tasks.

### Features
* Added NaturalDocs compatible comment lines for SystemVerilog and UVM snippet constructs.

## [1.0.13]
### Bugfixes
* [#2] Fixed unscoped property declaration in generate block. Due to tmLanguage limitations property-endproperty constructs will now be scoped in _all_ begin-end blocks as they cannot be differentiated from generate block begin-end blocks. Also changed the scoping of *genvar* keyword; it is moved to the net_types group.

## [1.0.12]
### Bugfixes
* Fixed reindent bug. One ')' was lost somewhere in the process.

## [1.0.10] & [1.0.11]
### Features
* Marketplace related changes and fixes.

## [1.0.9]
### Features
* Added several snippet to support quick UVM class deployment. Sequence item received a specialized snippet and also the do_ sequence item method boilerplates are added. (eg.: uvm_sequence_item, uvm_sequence_item_do_copy etc.)
* Snippets are uniformized and end-of-line added to most of them.
* Added snippets for separators/headers (eg.: sv_separator_full, sv_separator_block etc.)
* Added protected|static|local method qualifiers to indentation rules.

## [1.0.8]
### Features
* Better support of UVM source code, eg.: /* local */ extern functions, oneliner tasks and functions, etc.
* Minor bugfixes in UVM phase snippets.

## [1.0.7]
### Features
* Added external stubs for UVM phases; and also added UVM_runtime_phases to the snippet library.

## [1.0.6]
### Features
* Added net and variable types to the compilation unit namespace
* Compiler directives and system tasks are now correctly included in the appropriate scopes
* External function declaration now correctly scopes the function name and the return type

## [1.0.5]
### Features
* Added folding rules for all langauage constructs eg.: module-endmodule, class-endclass etc., to be foldable even when the indentation of the code is not perfect. Exceptions: begin-end, fork-join, as the editor has certain limitations; eg.: a line of 'end else begin' breaks the processing. Reindent still works on these lines and folding by indentation is possible
* Also indentation regex rules are now more verbose; for some reason the folding markers work this way
* Added support for user defined macro calls
### Bugfixes
* Compiler directives now scope correctly; standardized end-of-line termination on several scopes
* Global clocking without a clocking_identifier now scopes correctly
* Standardized end label scoping of classes, properties and sequences
* Typedef with queue types will scope correctly
* Module instantiation, function call parameters now scope correctly

## [1.0.4]
* Added snippet demonstration gif
* Added correct scoping to externally defined functions, tasks, modules, etc.
* End label handling of module, interface, etc. constructs moved to the punctuation region.
* End labels are handled well even when the previous end(construct) keyword is stray and illegal.

## [1.0.2]
* Corrected indent pattern on open curly braces
* Added special formal types to parenthesis (sequence, untyped)
* Fixed attribute bug in always(*) constructs
* Added operators to covergroup body (iff operator)
* Added nettype user defined type
* Added property and sequence to clocking block

## [1.0.1]
### License information and screenshots are added

## [1.0.0]
### Initial release
#### The addon supports the following features
* classes
* comments, attributes, various conventional highlights (accessors, numbers, etc.)
* constraint blocks
* coverage
* interfaces
* modules
* packages
* tasks and functions

#### Limited support on the following features
* checkers
* programs
* user-defined primitives
* UVM related classes, types, macros and functions

#### Unsupported features and problems
* specify blocks
* Logical '<=' and the assignment '<=' are not differentiated yet. Solution: logical operators shall only be applied inside of a parenthesis.(?)
* A.1.2: SystemVerilog source text: { package_import_declaration } in module_nonansi_header, module_ansi_header is not supported.

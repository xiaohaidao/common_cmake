
#
# GETTEXT_LANG_LIST(
#   TARGET <target>
#   SRC <cpp_h_file> # example: src/*.cpp src/*.h
#   PO_DIR <po_output_dir>
#   MO_DIR <mo_output_dir>
#   ...  <lang> # zh_CN.utf8 fr_FR.utf8
#)
#
# make lang_init # create pot and po files
# make lang_update # update po files and create mo file
#

find_package(Gettext REQUIRED)
if(NOT GETTEXT_FOUND)
    message(FATAL_ERROR "gettext not found")
endif()

find_program(GETTEXT_XGETTEXT_EXECUTABLE xgettext)
find_program(GETTEXT_MSGINIT_EXECUTABLE msginit)

function(GETTEXT_LANG_LIST)
    set(_options)
    set(_one_arg TARGET PO_DIR MO_DIR)
    set(_multi_arg SRC)
    CMAKE_PARSE_ARGUMENTS(_prefix "${_options}" "${_one_arg}" "${_multi_arg}" ${ARGN})
    set(_lang_list ${_prefix_UNPARSED_ARGUMENTS})
    set(_target ${_prefix_TARGET})
    set(_src_list ${_prefix_SRC})
    set(_output_path ${_prefix_PO_DIR})
    set(_bin_path ${_prefix_MO_DIR})

    get_filename_component(_output_path ${_output_path} ABSOLUTE)
    get_filename_component(_bin_path ${_bin_path} ABSOLUTE)

    set(_pot_path ${_output_path}/${_target}.pot)
    file(GLOB_RECURSE _src_all_files ${_src_list})

    get_filename_component(_pot_dir ${_pot_path} DIRECTORY)
    file(MAKE_DIRECTORY ${_pot_dir})

    set(_pot_commnd ${GETTEXT_XGETTEXT_EXECUTABLE}
            -c -k_ -kN_ --from-code=utf-8 --omit-header
            --package-name=${_target}
            --package-version=1.0
            ${_src_all_files}
            -o ${_pot_path}
    )
    add_custom_target(lang_update
        COMMAND ${_pot_commnd}
    )
    add_custom_target(lang_init
        COMMAND ${_pot_commnd}
    )

    foreach(lang ${_lang_list})
        set(_mo_tmp_path ${PROJECT_BINARY_DIR}/gettext/lang/${lang}/LC_MESSAGES/${_target}.mo)
        set(_mo_path ${_bin_path}/${lang}/LC_MESSAGES/${_target}.mo)
        set(_po_path ${_output_path}/${_target}_${lang}.po)

        get_filename_component(_mo_dir ${_mo_tmp_path} DIRECTORY)
        file(MAKE_DIRECTORY ${_mo_dir})

        add_custom_command(
            OUTPUT ${_po_path}
            COMMAND ${GETTEXT_MSGMERGE_EXECUTABLE}
                -U -v --backup=none
                ${_po_path} ${_pot_path}
            COMMAND ${GETTEXT_MSGFMT_EXECUTABLE}
                -c -v
                ${_po_path}
                -o ${_mo_tmp_path}
            COMMAND ${CMAKE_COMMAND} -E copy
              ${_mo_tmp_path} ${_mo_path}
            DEPENDS ${_pot_path} lang_update
        )
        if(NOT EXISTS ${_po_path})
            add_custom_command(
                TARGET lang_init
                POST_BUILD
                COMMAND ${GETTEXT_MSGINIT_EXECUTABLE}
                    --no-translator -l ${lang}
                    -i ${_pot_path}
                    -o ${_po_path}
            )
        endif()
    endforeach()
endfunction()

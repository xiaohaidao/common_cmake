function(add_test_exe target)
    set(test_name ${target})
    add_executable(${test_name} ${ARGN})

    set(install_export_target ${test_name})
    include(use_install_export)

    add_test(NAME ${test_name} COMMAND $<TARGET_FILE:${test_name}>)
endfunction()

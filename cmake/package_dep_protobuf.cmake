#
# @brief protobuf link ${generate_protobuf TARGET}
#

include(package_module_export)

package_module_export(
    TARGET
    Protobuf
    GIT_URL
    https://github.com/protocolbuffers/protobuf.git
    GIT_TAGS
    # v24.4 # c++14
    v21.12 # c++11
    CMAKE_ARGS
    -Dprotobuf_BUILD_TESTS=OFF
    -Dprotobuf_MSVC_STATIC_RUNTIME=ON)

function(generate_protobuf)
    set(_options)
    set(_one_arg TARGET IMPORT_DIR)
    set(_multi_arg PROTO_SRC)
    cmake_parse_arguments(_prefix "${_options}" "${_one_arg}" "${_multi_arg}"
                          ${ARGN})
    set(_unuse_list ${_prefix_UNPARSED_ARGUMENTS})
    set(_target ${_prefix_TARGET})
    set(_import_dir ${_prefix_IMPORT_DIR})
    set(_proto_src ${_prefix_PROTO_SRC})

    add_library(${_target} OBJECT "${_proto_src}")

    target_link_libraries(${_target} PUBLIC protobuf::libprotobuf)

    set(PROTO_BINARY_DIR "${CMAKE_CURRENT_BINARY_DIR}/")
    set(PROTO_IMPORT_DIRS "${CMAKE_CURRENT_LIST_DIR}/${_import_dir}")

    target_include_directories(${_target}
                               PUBLIC "$<BUILD_INTERFACE:${PROTO_BINARY_DIR}>")

    protobuf_generate(TARGET ${_target} IMPORT_DIRS ${PROTO_IMPORT_DIRS}
                      PROTOC_OUT_DIR "${PROTO_BINARY_DIR}")

endfunction()

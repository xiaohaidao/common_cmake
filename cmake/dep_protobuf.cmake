
##
# @brief protobuf
# @GIT_PROTOBUF_REPOSITORY
# @PROTOBUF_VERSION
# @PROTOBUF_INSTALL_DIR
#
if (NOT GIT_PROTOBUF_REPOSITORY)
    set(GIT_PROTOBUF_REPOSITORY
        ${GITHUB_URL_PREFIX}https://github.com/protocolbuffers/protobuf)
endif()
if (NOT PROTOBUF_VERSION)
    set(PROTOBUF_VERSION v24.4) # need c++14
endif()

FIND_OR_BUILD(
    TARGET Protobuf
    GIT_URL ${GIT_PROTOBUF_REPOSITORY}
    GIT_TAGS ${PROTOBUF_VERSION}
    INSTALL_DIR ${PROTOBUF_INSTALL_DIR}
    CMAKE_APPEND -Dprotobuf_BUILD_TESTS=OFF
    -Dprotobuf_MSVC_STATIC_RUNTIME=ON
)

function(GENERATE_PROTOBUF)
    set(_options)
    set(_one_arg TARGET IMPORT_DIR)
    set(_multi_arg PROTO_SRC)
    CMAKE_PARSE_ARGUMENTS(_prefix "${_options}" "${_one_arg}" "${_multi_arg}" ${ARGN})
    set(_unuse_list ${_prefix_UNPARSED_ARGUMENTS})
    set(_target ${_prefix_TARGET})
    set(_import_dir ${_prefix_IMPORT_DIR})
    set(_proto_src ${_prefix_PROTO_SRC})

    add_library(${_target} OBJECT "${_proto_src}")

    target_link_libraries(${_target} PUBLIC protobuf::libprotobuf)

    set(PROTO_BINARY_DIR "${CMAKE_CURRENT_BINARY_DIR}/")
    set(PROTO_IMPORT_DIRS "${CMAKE_CURRENT_LIST_DIR}/${_import_dir}")

    target_include_directories(${_target} PUBLIC "$<BUILD_INTERFACE:${PROTO_BINARY_DIR}>")

    protobuf_generate(
        TARGET ${_target}
        IMPORT_DIRS ${PROTO_IMPORT_DIRS}
        PROTOC_OUT_DIR "${PROTO_BINARY_DIR}")

endfunction()

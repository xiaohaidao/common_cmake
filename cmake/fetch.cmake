macro(fetch_add_packet_macro name)
    include(FetchContent)
    FetchContent_Declare(
        ${name}
        ${ARGN}
        GIT_SHALLOW ON
        GIT_PROGRESS ON)
    string(TOUPPER ${name} name_upper)
    set(FETCHCONTENT_UPDATES_DISCONNECTED_${name_upper} ON)
    # or set(FETCHCONTENT_FULLY_DISCONNECTED OFF)
    FetchContent_MakeAvailable(${name})
endmacro()

function(fetch_add_packet)
    fetch_add_packet_macro(${ARGV})
endfunction()

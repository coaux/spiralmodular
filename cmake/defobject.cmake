
function(defobject _name)
  add_library(${_name} OBJECT ${ARGN})
  target_include_directories(${_name} PUBLIC
    ${SSM_BUILD_ROOT}
    ${SSM_SOURCE_ROOT}
  )
endfunction()

function(defplugin _name)
  add_library(${_name} SHARED
    # ${SSM_SOURCE_ROOT}/SpiralSound/Sample.C
    # ${SSM_SOURCE_ROOT}/SpiralSound/ChannelHandler.C
    # ${SSM_SOURCE_ROOT}/SpiralSound/SpiralInfo.C
    # ${SSM_SOURCE_ROOT}/GUI/Widgets/SpiralGUI.C
    # ${SSM_SOURCE_ROOT}/SpiralSound/Plugins/SpiralPluginGUI.C
    # ${SSM_SOURCE_ROOT}/SpiralSound/Plugins/SpiralPlugin.C
    ${ARGN}
  )
  target_link_libraries(${_name} PUBLIC
    Sample ChannelHandler SpiralInfo SpiralGUI
    SpiralPluginGUI SpiralPlugin
  )
  target_link_libraries(${_name} PUBLIC ${FLTK_LIBRARIES})
  target_include_directories(${_name} PUBLIC
    ${SSM_BUILD_ROOT}
    ${SSM_SOURCE_ROOT}
  )
  set_target_properties(${_name} PROPERTIES
    CXX_VISIBILITY_PRESET hidden
    VISIBILITY_INLINES_HIDDEN ON
    POSITION_INDEPENDENT_CODE ON
  )
endfunction()

function(defapp ${_name})
  add_executable(${_name} ${ARGN})
  target_include_directories(${_name} PRIVATE
    ${SSM_BUILD_ROOT}
    ${SSM_SOURCE_ROOT}
  )
  if(UNIX)
    target_link_options(${_name} PRIVATE -rdynamic)
  endif()
endfunction()

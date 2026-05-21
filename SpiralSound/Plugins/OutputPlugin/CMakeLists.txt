
defplugin(OutputPlugin
  OutputPlugin.C OutputPluginGUI.C
)
include(GNUInstallDirs)
## add'l libraries
target_link_libraries(OutputPlugin PUBLIC Fl_Knob)

message(STATUS "Checking for pulsedsp in ${SSM_TARGET_PREFIX}/${CMAKE_INSTALL_LIBDIR}/pulseaudio, ${CMAKE_INSTALL_FULL_LIBDIR}/pulseaudio")
find_library(PULSE_DSP pulsedsp
  HINTS ${SSM_TARGET_PREFIX}/${CMAKE_INSTALL_LIBDIR}/pulseaudio ${CMAKE_INSTALL_FULL_LIBDIR}/pulseaudio
)
if(${PULSE_DSP} EQUAL PULSE_DSP-NOTFOUND)
  message(STATUS "libpulsedsp not found")
else()
  message(STATUS "found lipulsedsp: ${PULSE_DSP}")
  target_link_libraries(OutputPlugin PUBLIC ${PULSE_DSP})
endif()

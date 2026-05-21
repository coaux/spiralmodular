
cmake_minimum_required(VERSION 4.2)

project(spiralmodular VERSION 1.0.0
  DESCRIPTION "SpiralSynthModular"
  LANGUAGES CXX
)

set(CMAKE_CXX_STANDARD 23) # C++23 ranges
set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(CMAKE_POSITION_INDEPENDENT_CODE ON)

include(GNUInstallDirs)
if(DEFINED ENV{PREFIX})
  set(SSM_TARGET_PREFIX ${ENV{PREFIX}})
else()
  set(SSM_TARGET_PREFIX "/usr")
endif()

find_package(PkgConfig QUIET REQUIRED)

set(CACHE{SSM_PLUGIN_DIR}
    TYPE PATH
    HELP "default SSM plugin directory (SpiralInfo)"
    VALUE "${CMAKE_INSTALL_FULL_LIBDIR}/SpiralPlugins"
)

set(CACHE{SSM_WITH_ALSA}
    TYPE BOOL
    HELP "Build with ALSA MIDI support (Mutually exclusive to SSM_WITH_OSS)"
    VALUE ON
)

set(CACHE{SSM_WITH_OSS}
    TYPE BOOL
    HELP "Build with Open Sound System MIDI support (Mutually exclusive to SSM_WITH_ALSA)"
    VALUE OFF
)

if(SSM_WITH_ALSA AND SSM_WITH_OSS)
    message(FATAL_ERROR "Mutually exclusive options: SSM_WITH_ALSA, SSM_WITH_OSS")
endif()

set(CACHE{SSM_WITH_JACK}
    TYPE BOOL
    HELP "Build JackPlugin"
    VALUE ON
)

set(CACHE{SSM_WITH_LADSPA}
    TYPE BOOL
    HELP "Build LADSPAPlugin"
    VALUE ON
)

set(CACHE{SSM_WITH_SNDFILE}
    TYPE BOOL
    HELP "Use libsndfile for waveform samples"
    VALUE ON
)

set(SSM_SOURCE_ROOT ${CMAKE_CURRENT_LIST_DIR})
set(SSM_BUILD_ROOT ${CMAKE_CURRENT_BINARY_DIR})
configure_file(config_new.in ${SSM_BUILD_ROOT}/config.h @ONLY)
include(./cmake/defobject.cmake)


set(SSM_PLUGINS
    AmpPlugin AnotherFilterPlugin
    BeatMatchPlugin
    ControllerPlugin CounterPlugin
    DelayPlugin DiskWriterPlugin DistributorPlugin
    EchoPlugin EnvFollowerPlugin EnvelopePlugin
    FilterPlugin FlipflopPlugin FormantFilterPlugin
    KeyboardPlugin
    LFOPlugin LogicPlugin
    MasherPlugin MatrixPlugin MeterPlugin MidiPlugin MixSwitchPlugin
    MixerPlugin MoogFilterPlugin MousePlugin
    NoisePlugin NoteSnapPlugin
    OperatorPlugin OscillatorPlugin OutputPlugin
    PoshSamplerPlugin
    RingModPlugin
    SVFilterPlugin SampleHoldPlugin ScopePlugin SeqSelectorPlugin
    SmoothPlugin SpiralLoopPlugin SplitSwitchPlugin SplitterPlugin
    StereoMixerPlugin StreamPlugin SwitchPlugin
    TranslatePlugin TransposePlugin TrigPlugin
    WaveShaperPlugin WaveTablePlugin
    XFadePlugin
)

set(FLTK_SKIP_FLUID ON) # using existing *.cxx files
set(FLTK_SKIP_FORMS ON)
set(FLTK_SKIP_IMAGES ON)
find_package(FLTK REQUIRED)
find_package(OpenGL REQUIRED COMPONENTS OpenGL)

set(Boost_USE_STATIC_LIBS        OFF)
find_package(Boost REQUIRED COMPONENTS exception filesystem)
## no package for header-only Boost components on Fedora (assume available)
# find_package(Boost REQUIRED COMPONENTS dll
#     CONFIG)

find_package(argparse REQUIRED)

pkg_check_modules(XDG_BASEDIR REQUIRED libxdg-basedir)


if(SSM_WITH_ALSA)
    ## ALSA MIDI
    pkg_check_modules(ALSA REQUIRED alsa)
else()
    set(ALSA_LIBRARIES)
    set(ALSA_CFLAGS)
    set(ALSA_CFLAGS_OTHER)
endif()

# if(SSM_WITH_OSS)
#     ## OSS sound, OSS MIDI
# endif()

if(SSM_WITH_SNDFILE)
    pkg_check_modules(SNDFILE REQUIRED sndfile)
else()
    set(SNDFILE_LIBRARIES)
    set(SNDFILE_CFLAGS)
    set(SNDFILE_CFLAGS_OTHER)
endif()

if(SSM_WITH_LADSPA)
    pkg_check_modules(LRDF REQUIRED lrdf)
    list(PREPEND SSM_PLUGINS LADSPAPlugin)
else()
    set(LRDF_LIBRARIES)
    set(LRDF_CFLAGS)
    set(LRDF_CFLAGS_OTHER)
endif()

if(SSM_WITH_JACK)
    pkg_check_modules(JACK REQUIRED jack)
    list(PREPEND SSM_PLUGINS JackPlugin)
else()
    set(JACK_LIBRARIES)
    set(JACK_CFLAGS)
    set(JACK_CFLAGS_OTHER)
endif()

add_subdirectory(GUI)
add_subdirectory(SpiralSound)

defobject(GraphSort OBJECT GraphSort.C)

defobject(SettingsWindow OBJECT SettingsWindow.C)

defobject(SpiralSynthModular OBJECT SpiralSynthModular.C GraphSort.C)

target_link_libraries(SpiralSynthModular PUBLIC
    Boost::filesystem
    GraphSort PluginManager
)

target_link_libraries(SpiralSynthModular PUBLIC
    Fl_CommentGUI
    Fl_Canvas
    PawfalYesNo
    PawfalInput
    PluginManager
    SpiralPlugin
)

add_executable(spiralsynthmodular "main.cpp")

target_link_libraries(spiralsynthmodular PRIVATE
    argparse::argparse
    Boost::exception
    ${XDG_BASEDIR_LIBS}
    ${FLTK_LIBRARIES}
    SpiralInfo
    SpiralSynthModular
    ChannelHandler
    SpiralPlugin
    Sample
    PluginManager
    SettingsWindow
    PawfalYesNo
    Fl_CommentGUI
    Fl_DeviceGUI
    Fl_Canvas
)

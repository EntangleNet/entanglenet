//
// Created by victoria-sagady on 4/18/25.
//

#include "portaudio.h"
#include <array>
#include <iostream>

#ifdef _WIN32
#include <windows.h>

#if PA_USE_ASIO
#include "pa_asio.h"
#endif
#endif

static void PrintSupportedStandardSampleRates(
  const PaStreamParameters* inParameters,
  const PaStreamParameters* outParameters)
{
  constexpr std::array<double, 13> standardSampleRates = {
  8000.0, 9600.0, 11025.0, 12000.0, 16000.0, 22050.0, 24000.0, 32000.0, 44100.0, 48000.0, 64000.0, 96000.0, 192000.0
    };

  int printCount = 0;
  for (const auto& sampleRate : standardSampleRates) {
    if (const PaError err = Pa_IsFormatSupported(inParameters, outParameters, sampleRate)) {
      if (printCount == 0) {
        std::cout << "\t&8.2f" << sampleRate;
        printCount = 1;
      }
    }
  }
}

int  main() {
  //std::cout << "Hello World!\n";
  return 0;
}
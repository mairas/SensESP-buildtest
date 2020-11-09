#include <Arduino.h>

#include "sensesp_app.h"
#include "sensesp_app_builder.h"
#include "signalk/signalk_output.h"

ReactESP app([]() {
  #ifndef SERIAL_DEBUG_DISABLED
  SetupSerialDebug(115200);
  #endif

  SensESPAppBuilder builder;

  sensesp_app = builder
    .set_hostname("sensesp-test")
    ->set_wifi("my-wifi-ssid", "my-wifi-password")
    ->set_sk_server("my_server.lan", 80)
    ->get_app();
  sensesp_app->enable();
});


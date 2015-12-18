/**
 *  Copyright 2014 Nest Labs Inc. All Rights Reserved.
 *
 *  Licensed under the Apache License, Version 2.0 (the "License");
 *  you may not use this file except in compliance with the License.
 *  You may obtain a copy of the License at
 *
 *        http://www.apache.org/licenses/LICENSE-2.0
 *
 *  Unless required by applicable law or agreed to in writing, software
 *  distributed under the License is distributed on an "AS IS" BASIS,
 *  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 *  See the License for the specific language governing permissions and
 *  limitations under the License.
 */

#ifndef iOS_NestDK_Constants_h
#define iOS_NestDK_Constants_h

#define NestClientID @"6fa2a996-5691-4dd8-aeb0-c0c8b4394655"
#define NestClientSecret @"6N9l1kXsXSrnURLHG23qsLZrX"
#define NestCurrentAPIDomain @"home.nest.com"
#define NestState @"SOMESTATE"
#define kNotoficationAccessToken @"kNotoficationAccessToken"

// Thermostat fields
#define THERMOSTAT_PATH @"devices/thermostats"
#define FAN_TIMER_ACTIVE @"fan_timer_active"
#define HAS_FAN @"has_fan"
#define TARGET_TEMPERATURE_F @"target_temperature_f"
#define TARGET_TEMPERATURE_LOW_F @"target_temperature_low_f"
#define TARGET_TEMPERATURE_HIGH_F @"target_temperature_high_f"
#define AMBIENT_TEMPERATURE_F @"ambient_temperature_f"
#define AMBIENT_TEMPERATURE_LOW_F @"away_temperature_low_f"
#define AMBIENT_TEMPERATURE_HIGH_F @"away_temperature_high_f"
#define NAME_LONG @"name_long"
#define DEVICE_ID @"device_id"

// Camera fields
#define CAMERA_PATH @"devices/cameras"
#define IS_AUDIO_INPUT_DEVICE @"is_audio_input_enabled"
#define IS_ONLINE @"is_online"
#define IS_STREAMING @"is_streaming"
#define IS_VIDEO_HYSTORY_ENABLED @"is_video_history_enabled"
#define LAST_EVENT @"last_event"
#define NAME_LONG @"name_long"

// Smoke fields
#define SMOKE_PATH @"devices/smoke_co_alarms"
#define CO_ALARM_STATE @"co_alarm_state"
#define SMOKE_ALARM_STATE @"smoke_alarm_state"
#define BATTERY_HEALTH @"battery_health"
#define MANUAL_TEST @"is_manual_test_active"

#define kDeviceCamera @"cameras"
#define kDeviceThermostat @"thermostats"
#define kDeviceSmoke @"smoke_co_alarms"

#endif

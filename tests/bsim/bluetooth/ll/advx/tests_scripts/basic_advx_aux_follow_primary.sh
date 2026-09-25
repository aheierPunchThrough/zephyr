#!/usr/bin/env bash
# SPDX-FileCopyrightText: Copyright (c) 2026 Punch Through Design
# SPDX-License-Identifier: Apache-2.0

source ${ZEPHYR_BASE}/tests/bsim/sh_common.source

# Extended and Periodic Advertising with AUX_ADV_IND following the primary
# channel PDUs, using the split controller (ULL LLL)
simulation_id="${BOARD_TS}_basic_advx_aux_follow_primary"
verbosity_level=2
EXECUTE_TIMEOUT=120

cd ${BSIM_OUT_PATH}/bin

Execute ./bs_${BOARD_TS}_tests_bsim_bluetooth_ll_advx_prj_conf_overlay-aux_follow_primary_conf \
  -v=${verbosity_level} -s=${simulation_id} -RealEncryption=1 -d=0 -testid=advx

Execute ./bs_${BOARD_TS}_tests_bsim_bluetooth_ll_advx_prj_conf_overlay-aux_follow_primary_conf \
  -v=${verbosity_level} -s=${simulation_id} -RealEncryption=1 -d=1 -testid=scanx

Execute ./bs_2G4_phy_v1 -v=${verbosity_level} -s=${simulation_id} \
  -D=2 -sim_length=60e6 $@

wait_for_background_jobs

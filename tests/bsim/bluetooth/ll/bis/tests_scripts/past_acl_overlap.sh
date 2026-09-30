#!/usr/bin/env bash
# SPDX-FileCopyrightText: Copyright (c) 2026 Punch Through Design
# SPDX-License-Identifier: Apache-2.0

source ${ZEPHYR_BASE}/tests/bsim/sh_common.source

# PAST with a 20 ms ACL and 100 ms Periodic Advertising interval. With these
# seeds the ACL events of the PAST receiver overlap every attempt to establish
# the transferred sync.
simulation_id="${BOARD_TS}_past_acl_overlap"
verbosity_level=2
test_args="conn_interval=16 per_adv_interval=80"

cd ${BSIM_OUT_PATH}/bin

Execute ./bs_${BOARD_TS}_tests_bsim_bluetooth_ll_bis_prj_past_conf \
  -v=${verbosity_level} -s=${simulation_id} -d=0 -rs=170 -testid=receive_past \
  -argstest ${test_args}

Execute ./bs_${BOARD_TS}_tests_bsim_bluetooth_ll_bis_prj_past_conf \
  -v=${verbosity_level} -s=${simulation_id} -d=1 -rs=171 -testid=broadcast_pa \
  -argstest ${test_args}

Execute ./bs_${BOARD_TS}_tests_bsim_bluetooth_ll_bis_prj_past_conf \
  -v=${verbosity_level} -s=${simulation_id} -d=2 -rs=172 -testid=send_past \
  -argstest ${test_args}

Execute ./bs_2G4_phy_v1 -v=${verbosity_level} -s=${simulation_id} \
  -D=3 -rs=17 -sim_length=60e6 $@

wait_for_background_jobs

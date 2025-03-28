-----------------For support, scripts, and more----------------
--------------- https://discord.gg/wasabiscripts  -------------
---------------------------------------------------------------
if Config.Language ~= 'ko' then return end

Strings = {
    no_society_account = '[^3경고^0] 사회 계정이 존재하지 않습니다: %s',
    ems_worker = '구급차 근무자',
    not_authorized = '승인되지 않음',
    not_authorized_desc = '이것을 사용할 권한이 없습니다!',
    not_on_duty = '근무 중이 아님',
    not_on_duty_desc = '근무 중이 아닙니다!',
    gps_enabled = 'GPS 활성화됨',
    gps_enabled_desc = 'GPS를 활성화했습니다',
    gps_disabled = 'GPS 비활성화됨',
    gps_disabled_desc = 'GPS를 비활성화했습니다',

    possible_cause = '가능한 원인',

    full_name = '이름',
    pulse = '맥박',
    bpm = 'BPM: %s',
    bleed_rate = '출혈률',
    bleed_rate_low = '낮음',
    bleed_rate_medium = '보통',
    bleed_rate_high = '높음',
    no_name = '이름 없음',
    injuries = '현재 부상',


    get_off_stretcher_ui = '[E] - 들것에서 내리기',
    move = '이동',
    move_desc = '들것을 이동하기',
    put_in_vehicle = '차량에 넣기',
    stretcher_in_vehicle = '차량에 들것 넣기',
    put_in_vehicle_desc = '차량에 들것을 넣기',
    place_on_stretcher = '환자 놓기',
    place_on_stretcher_desc = '들것에 환자를 놓기',
    remove_from_stretcher = '환자 제거',
    remove_from_stretcher_desc = '들것에서 환자를 제거하기',
    not_found = '찾을 수 없음',
    already_occupied_ambulance = '이미 사용 중',
    already_occupied_ambulance_desc = '이 구급차는 이미 사용 중입니다!',
    already_occupied_stretcher = '이미 사용 중',
    already_occupied_stretcher_desc = '이 들것은 이미 사용 중입니다!',
    vehicle_occupied = '차량 사용 중',
    vehicle_occupied_desc = '누군가 운전하는 동안 이것을 할 수 없습니다!',
    not_occupied_stretcher = '사용하지 않음',
    not_occupied_stretcher_desc = '이 들것은 사용 중이지 않습니다!',
    stretcher_placement_blocked = '배치 차단됨',
    stretcher_placement_blocked_desc = '여기에 들것을 배치할 수 없습니다!',
    knocked_out = '기절함',
    knocked_out_desc = '당신은 기절했습니다!',
    checkin_cooldown = '체크인 대기시간',
    checkin_cooldown_desc = '체크인을 너무 빨리 시도하고 있습니다. 잠시 기다려주세요.',
    checkingin_progress = '체크인 중...',
    remove_dead_target = '의식 없는 사람 제거',
    ply_injury_head = '머리',
    ply_injury_neck = '목',
    ply_injury_spine = '척추',
    ply_injury_upper = '상체',
    ply_injury_lower = '하체',
    ply_injury_left_arm = '왼팔',
    ply_injury_left_leg = '왼쪽 다리',
    ply_injury_right_arm = '오른팔',
    ply_injury_right_leg = '오른쪽 다리',
    diagnosing_patient_progress = '환자 진단 중...',
    treating_patient_progress = '환자 치료 중...',
    recovering_progress = '회복 중...',
    injury_report = '부상 보고',
    none = '없음',
    mild = '경미함',
    moderate = '중간',
    severe = '심각함',
    deadly = '치명적임',
    injury_report_locations = '부위',
    injury_report_type = '부상 유형: %s',
    injury_report_severity = '심각도: %s',
    injury_report_bleed = '출혈',
    light_injury_title = '경미한 부상',
    moderate_injury_title = '중간 부상',
    extreme_injury_title = '극심한 부상',
    injury_bleed_notify = '부상 및 출혈 경고',
    light_injury_desc = '당신의 %s가 다쳤습니다, 의사를 방문하는 것을 고려하세요!',
    moderate_injury_desc = '당신의 %s가 매우 다쳤습니다, 의사가 필요합니다!',
    extreme_injury_desc = '당신의 %s가 극도로 심각하게 다쳤습니다. 너무 늦기 전에 의사에게 가세요!',
    injury_msg_one = '당신은 중대한 부상을 입었습니다.',
    injury_msg_two = '당신은 심각한 부상을 입었습니다.',
    injury_msg_three = '당신은 매우 심각한 부상을 입었습니다.',
    injury_msg_four = '당신은 위독한 부상을 입었습니다.',
    bleed_msg_one = '출혈 중입니다.',
    bleed_msg_two = '심하게 출혈하고 있습니다. 압력을 가하세요.',
    bleed_msg_three = '출혈로 인해 위험합니다!',
    fainted_title = '기절함',
    fainted_so_high_desc = '너무 높아서 기절했습니다.',
    cant_jump_title = '뛸 수 없음!',
    cant_jump_desc = '부상이 심해 뛸 수 없습니다',
    blackout_title = '의식 상실',
    blackout_desc = '%s 부상으로 인해 의식을 잃었습니다! 즉시 의료 도움을 받으세요!',
    treated_fully_desc = '치료를 받고 이전보다 훨씬 나아졌습니다!',
    treated_not_fully_desc = '치료를 받았지만 추가 치료가 필요합니다.',
    prescription_menu = '처방 메뉴',
    prescription_menu_desc = '처방에 접근하고 관리하기',
    no_stretcher_detected = '구급 들것 미검출',
    no_stretcher_detected_desc = '활성화된 구급 들것이 검출되지 않았습니다!',
    cant_run = '달릴 수 없음',
    cant_run_desc = '부상이 심해 달릴 수 없습니다!',
    no_back_seat = '사용 가능한 좌석 없음',
    no_back_seat_desc = '이 구급차의 뒷좌석에는 좌석이 없습니다',
    enter_vehicle_back = '구급차 (뒤쪽) 탑승',
    stretcher_already_deployed = '들것 이미 배치됨',
    stretcher_already_deployed_desc = '이 구급차에 할당된 들것은 이미 제거되었습니다.',
    send_stretcher_home = '차량으로 복귀',
    ambulance_not_found = '들것은 제거되었지만 복귀할 구급차를 찾을 수 없습니다!',
    bleedout = '출혈 중',
    player_injury_critical_desc = '플레이어가 %s 부상으로 인해 위독한 상태입니다!',
    gps_active = 'GPS 활성화',
    gps_active_desc = '플레이어 %s가 GPS를 활성화했습니다',
    gps_deactive = 'GPS 비활성화',
    gps_deactive_desc = '플레이어 %s가 GPS를 비활성화했습니다',
    no_wsb = '^0[^3경고^0] wasabi_bridge가 프레임워크 이후 또는 리소스 이전에 시작되지 않았습니다: %s',
    spawn_blocked = '차고 막힘',
    spawn_blocked_desc = '출구가 막혀 있어 차량을 꺼낼 수 없습니다!',
    menu_remove_crutch = '목발 제거',
    menu_remove_crutch_desc = '근처 환자에게서 목발 제거',
    menu_remove_chair = '휠체어 제거',
    menu_remove_chair_desc = '근처 환자에게서 휠체어 제거',
    toggle_stretcher = '드레셔 가져오기',
    toggle_stretcher_desc = '가장 가까운 차량에서 드레셔를 가져오기',
    no_vehicle_nearby = '차량',
    no_vehicle_nearby_desc = '주변에 차량이 없음',
    no_ambulance_nearby_desc = '주변에 구급차가 없음',
    on_duty = '근무 중',
    on_duty_desc = '근무 상태로 전환했습니다!',
    off_duty = '비근무',
    off_duty_desc = '비근무 상태로 전환했습니다!',
    amount = '금액',
    mr = 'Mr',
    mrs = 'Mrs',
    debt_collection = '채권 추심',
    db_email =
    '친애하는 %s %s, <br /><br />중앙 사법 징수 기관(CJCA)이 경찰로부터 받은 벌금을 청구했습니다.<br />귀하의 계좌에서 <strong>$%s</strong>가 출금되었습니다.<br /><br />감사합니다,<br />와사비 씨',
    fine_sent = '벌금 발송',
    fine_sent_desc = '$%s의 벌금을 성공적으로 발송했습니다!',
    fine_received = '벌금 수령',
    fine_received_desc = '$%s의 벌금을 받았습니다',
    log_killed_title = '플레이어 사망',
    log_killed_desc =
    '> *%s [%s]가 %s [%s]를 죽였습니다\n\n**살인자 정보:**\n이름: `%s`\n플레이어 ID: `%s`\n식별자: `%s`\nSteam: `%s`\nDiscord: `%s`\n라이센스: `%s`\n라이센스2: `%s`\nXBL: `%s`\nFiveM: `%s`\nIP: ||%s||\n\n**피해자 정보:**\n캐릭터 이름: `%s`\n플레이어 ID: `%s`\n식별자: `%s`\nSteam: `%s`\nDiscord: `%s`\n라이센스: `%s`\n라이센스2: `%s`\nXBL: `%s`\nFiveM: `%s`\nIP: ||%s||\n\n> **사망 원인:** `%s`',
    log_suicide_title = '플레이어 자살',
    log_suicide_desc =
    '> %s [%s]가 자살했습니다\n\n**플레이어 정보:**\n이름: `%s`\n플레이어 ID: `%s`\n식별자: `%s`\nSteam: `%s`\nDiscord: `%s`\n라이센스: `%s`\n라이센스2: `%s`\nXBL: `%s`\nFiveM: `%s`\nIP: ||%s||\n\n> **사망 원인:** `%s`',
    unknown = '알 수 없음',
    log_admin_revive_title = '관리자에 의한 플레이어 부활',
    log_admin_revive_desc =
    '> *%s [%s]가 관리자에 의해 %s [%s]를 부활시켰습니다\n\n**대상 정보:**\n이름: `%s`\n플레이어 ID: `%s`\n식별자: `%s`\nSteam: `%s`\nDiscord: `%s`\n라이센스: `%s`\n라이센스2: `%s`\nXBL: `%s`\nFiveM: `%s`\nIP: ||%s||\n\n**관리자 정보:**\n캐릭터 이름: `%s`\n플레이어 ID: `%s`\n식별자: `%s`\nSteam: `%s`\nDiscord: `%s`\n라이센스: `%s`\n라이센스2: `%s`\nXBL: `%s`\nFiveM: `%s`\nIP: ||%s||',
    log_self_revive_title = '관리자 자가 부활',
    log_self_revive_desc =
    '> %s [%s] 자가 부활했습니다\n\n**플레이어 정보:**\n이름: `%s`\n플레이어 ID: `%s`\n식별자: `%s`\nSteam: `%s`\nDiscord: `%s`\n라이센스: `%s`\n라이센스2: `%s`\nXBL: `%s`\nFiveM: `%s`\nIP: ||%s||',
    log_death_logs = '사망 로그',
    log_revive_logs = '부활 로그',
    log_combat_logs = '전투 로그',
    log_combatlog_title = '전투 로그',
    log_combatlog_desc =
    '> %s [%s] 전투 로그 \n\n**플레이어 정보:**\n이름: `%s`\n플레이어 ID: `%s`\n식별자: `%s`\nSteam: `%s`\nDiscord: `%s`\n라이센스: `%s`\n라이센스2: `%s`\nXBL: `%s`\nFiveM: `%s`\nIP: ||%s||',
    medbag_crutch = '목발',
    medbag_crutch_desc = '보행을 돕기 위한 목발',
    menu_crutch = '목발 적용',
    menu_crutch_desc = '근처 환자에게 목발 추가',
    medbag_chair = '휠체어',
    medbag_chair_desc = '걷지 못하는 환자를 위한 휠체어',
    menu_chair = '휠체어 적용',
    menu_chair_desc = '근처 환자에게 휠체어 추가',
    shot = '총격',
    stabbed = '찔림',
    beat = '둔감한 트라우마',
    burned = '화상',
    other = '알 수 없음',
    JobMenuTitle = 'EMS 메뉴',
    dispatch = '파견',
    dispatch_desc = '돕는 플레이어 확인',
    DispatchMenuTitle = '파견',
    GoBack = '뒤로 가기',
    key_map_text = '앰뷸런스 작업 메뉴',
    assistance_title = '도움 요청됨',
    assistance_desc = '누군가가 의료 지원을 요청했습니다!',
    respawn_available_in = '~r~%s 분 %s 초 후에 리스폰 가능~s~\n',
    respawn_bleedout_in = '~r~%s 분 %s 초 후 출혈로 사망합니다~s~\n',
    respawn_bleedout_prompt = '[~r~E~s~]를 누르고 리스폰하세요',
    distress_send = 'EMS에게 신호 보내기 위해 [~r~G~s~]를 누르세요',
    distress_sent_title = '도움 요청됨',
    distress_sent_desc = '신호가 사용 가능한 단위에게 보내졌습니다!',
    route_set_title = '경로 설정됨',
    route_set_desc = '고통받는 사람에게 경로지시를 설정했습니다!',
    diagnose_patient = '진단',
    diagnose_patient_desc = '가장 가까운 부상당한 환자를 진단하세요',
    no_requests = '활성 요청 없음',
    revive_patient = '부활',
    revive_patient_desc = '근처 환자를 부활시키려고 시도하세요',
    heal_patient = '치료',
    heal_patient_desc = '근처 환자를 치료하려고 시도하세요',
    sedate_patient = '진정',
    sedate_patient_desc = '근처 환자를 일시적으로 진정시키세요',
    drag_patient = '끌기',
    drag_patient_desc = '근처 부상당한 환자를 끌어 이동하세요',
    place_stretcher_target = '환자 추가 또는 제거',
    place_patient = '차량 안/밖에 놓기',
    place_patient_desc = '의식을 잃은 근처 환자를 차량 안/밖에 놓으세요',
    no_nearby = '찾을 수 없음',
    no_nearby_desc = '주변에 아무도 없는 것 같습니다',
    no_injury = '부상 없음',
    no_injury_desc = '이 사람은 어떤 치료도 필요하지 않은 것 같습니다',
    no_injury_dead_desc = '환자는 추가 치료가 필요하지 않는 것으로 보입니다. 제세동기를 사용하고 최선을 다해보세요!',
    player_injury = '부상당한 사람',
    player_injury_desc = '이 사람은 %s 상처가 있는 것 같습니다',
    player_not_unconscious = '의식 있는 플레이어',
    player_not_unconscious_desc = '플레이어는 의식이 있는 것으로 보입니다',
    player_unconscious = '의식 없는 플레이어',
    player_unconscious_desc = '이 치료를 위해 환자는 의식이 있어야 합니다!',
    player_reviving = '부활 중',
    player_reviving_desc = '환자 부활 진행 중',
    player_noitem = '부족한 아이템',
    player_noitem_desc = '이 작업에 필요한 아이템이 부족합니다!',
    player_successful_revive = '부활 완료',
    player_successful_revive_reward_desc = '환자를 성공적으로 부활시켰으며 $%s를 획득했습니다!',
    player_successful_revive_desc = '환자를 성공적으로 부활시켰습니다!',
    player_healing = '치료 중',
    player_healing_desc = '환자 치료 진행 중',
    player_successful_heal = '치료 완료',
    player_successful_heal_desc = '환자가 성공적으로 치료되었습니다!',
    player_healed_desc = '당신은 의사에 의해 성공적으로 치료되었습니다!',
    not_medic = '비인가 사용',
    not_medic_desc = '이 작업에 대한 교육을 받지 않았습니다!',
    target_sedated = '진정됨',
    target_sedated_desc = '의료 전문가에 의해 진정되었습니다',
    player_successful_sedate_desc = '환자를 성공적으로 진정시켰습니다',
    drop_bag_ui = '[E] - 가방 내려놓기',
    drop_stretch_ui = '[E] - 스트레처 놓기',
    pickup_bag_target = '줍기',
    move_target = '이동',
    interact_bag_target = '열기',
    successful = '성공',
    medbag_pickup = '의료 가방을 줍습니다',
    medbag_pickup_civ = '가방을 조사하고 유용한 것을 가져갔습니다',
    stretcher_pickup = '스트레처를 앰뷸런스로 보냈습니다',
    medbag = '의료 가방',
    medbag_tweezers = '진드기 집게',
    medbag_tweezers_desc = '총알을 제거하는 데 사용됩니다',
    medbag_suture = '봉합 키트',
    medbag_suture_desc = '상처를 봉합하는 데 사용됩니다',
    medbag_icepack = '아이스 팩',
    medbag_icepack_desc = '부어 있는 부분을 줄이는 데 사용됩니다',
    medbag_burncream = '화상 크림',
    medbag_burncream_desc = '화상을 치료하는 데 사용됩니다',
    medbag_defib = '제세동기',
    medbag_defib_desc = '환자 부활용으로 사용됩니다',
    medbag_medikit = '의료 키트',
    medbag_medikit_desc = '환자 치료에 사용됩니다',
    medbag_sedative = '진정제',
    medbag_sedative_desc = '환자 진정에 사용됩니다',
    medbag_stretcher = '접이식 스트레처',
    medbag_stretcher_desc = '환자 이동에 사용됩니다',
    item_grab = '의료 가방에서 도구를 꺼냈습니다',
    wrong_equipment = '잘못된 장비!',
    wrong_equipment_desc = '교육을 받았습니까?',
    player_not_injured = '부상 없음',
    player_not_injured_desc = '이 사람은 추가 치료가 필요하지 않는 것으로 보이며 제세동기를 사용할 수 있습니다',
    player_treated = '치료됨',
    player_treated_desc = '환자가 성공적으로 치료되었습니다',
    revive_command_help = '플레이어 부활을위한 관리자 명령',
    revive_command_arg = '플레이어 ID',
    reviveall_command_help = '모든 플레이어 부활을위한 관리자 명령',
    revivearea_command_help = '근처 플레이어 부활을위한 관리자 명령',
    revivearea_command_arg = '플레이어 부활 영역',
    resetdeathcount_command_help = '플레이어 사망 횟수 재설정을위한 관리자 명령',
    resetdeathcount_command_arg = '플레이어 ID',
    viewdeathcount_command_help = '사망 횟수를 확인하기 위한 명령',
    alive_again = '살아남음',
    alive_again_desc = '당신은 현지인에 의해 병원에 내려놓았습니다!',
    request_supplies_target = '의료 용품',
    currency = '달러',
    not_enough_funds = '자금 부족',
    not_enough_funds_desc = '자금이 부족합니다!',
    hospital_garage = '병원 차고',
    used_meditkit = '의료 키트 사용됨',
    used_medikit_desc = '자신을 치료했습니다',
    action_cancelled = '작업 취소됨',
    action_cancelled_desc = '최근 작업을 취소했습니다!',
    healing_self_prog = '상처 치료 중',
    checkin_hospital = '성공',
    checkin_hospital_desc = '병원 직원에 의한 성공적인 치료',
    max_ems = '응급 의료 스태프 사용 가능',
    max_ems_desc = '도시에 많은 응급 의료 스태프가 있습니다! 도움을 청하세요!',
    player_busy = '바쁨',
    player_busy_desc = '현재 이 작업을 수행하기에는 바쁩니다!',
    cloakroom = '탈의실',
    civilian_wear = '시민용 복장',
    bill_patient = '환자에게 청구서 보내기',
    bill_patient_desc = '근처 환자에게 청구서를 보냈습니다',
    invalid_entry = '유효하지 않음',
    invalid_entry_desc = '입력이 유효하지 않았습니다!',
    medical_services = '의료 서비스',
    hospital = '병원',
    interact_stretcher_ui = '[E] - 상호 작용',
    stretcher_menu_title = '스트레처 상호 작용',
    open_shop_ui = '[E] - 약국 열기'

}

UIStrings = {
    player_dying = "당신은 죽고 있습니다",
    player_passed = "당신은 돌아가셨습니다",
    ems_on_the_way = "긴급 서비스가 가고 있습니다!",
    press_ems_services = "긴급 서비스 요청",
    press_for_light = "빛을 보려면",
    hold = "잡다",
    time_to_respawn = "리스폰까지 남은 시간",
    press = "누르다",
    player_hurt_critical = "위독한 상태!",
    player_hurt_severe = "심각하게 다쳤습니다",
    player_hurt_unconscious = "의식 불명",
    player_hurt_unconscious_direct = "당신은 의식이 없습니다",
    player_hurt_find_help_or_ems = "응급 서비스 요청을 위해 <span class='color'>G</span>를 누르세요",
    player_hurt_time_to_live = "출혈 중",
    player_hurt_auto_respawn = "생명 징후가 사라지고 있습니다",
    player_hurt_respawn = "빛을 보려면 E를 누르세요",

    ems_online = "도움말 온라인",
    ems_offline = "도움말 사용할 수 없음",
    currently_online = "현재 온라인: "
}

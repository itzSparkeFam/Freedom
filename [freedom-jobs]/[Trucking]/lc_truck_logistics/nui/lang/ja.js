if (Lang == undefined) {
	var Lang = [];
}
Lang["ja"] = {
	new_contracts: "{0}分ごとに新たな案件が補充されます",
	top_trucker_distance_traveled: "累計走行距離: {0}km",
	top_trucker_exp: "EXP: {0}",
	sidebar_profile: "プロフィール",
	sidebar_jobs: "クイックジョブ",
	sidebar_jobs_2: "フレイトジョブ",
	sidebar_skills: "スキル",
	sidebar_diagnostic: "診断",
	sidebar_dealership: "ディーラー",
	sidebar_mytrucks: "トラック",
	sidebar_driver: "人材派遣会社",
	sidebar_mydrivers: "ドライバー",
	sidebar_bank: "銀行",
	sidebar_party: "パーティー",
	sidebar_close: "閉じる",

	confirmation_modal_sell_vehicle: "本当にこの車両を販売しますか?",
	confirmation_modal_delete_party: "本当にこのパーティーを解散しますか?",
	confirmation_modal_loan_payoff: "{0}の残高をすべて支払いますか？",

	statistics_page_title: "統計",
	statistics_page_desc: "トラック会社の統計",
	statistics_page_money: "資金",
	statistics_page_money_earned: "総獲得金額",
	statistics_page_deliveries: "納品完了",
	statistics_page_distance: "走行距離",
	statistics_page_exp: "合計獲得EXP",
	statistics_page_skill: "スキルポイント",
	statistics_page_trucks: "トラック",
	statistics_page_drivers: "ドライバー",
	statistics_page_top_truckers: "トップドライバー",
	statistics_page_top_truckers_desc: "最前線のトラック運転手ベスト10",

	contract_page_title: "クイックジョブ",
	contract_page_desc: "トラックを所有してなくても大丈夫。依頼者が全てを用意してくれます",
	contract_page_title_freight: "フレイト",
	contract_page_desc_freight: "自分のトラックを使ってより多くの収入を得ることができる",
	contract_page_distance: "距離: {0}km",
	contract_page_reward: "報酬: {0}",
	contract_page_cargo_explosive: "爆発物",
	contract_page_cargo_flammablegas: "可燃性ガス",
	contract_page_cargo_flammableliquid: "可燃性液体",
	contract_page_cargo_flammablesolid: "可燃性固体",
	contract_page_cargo_toxic: "有害物質",
	contract_page_cargo_corrosive: "腐食物質",
	contract_page_cargo_fragile: "割れ物",
	contract_page_cargo_valuable: "貴重品",
	contract_page_cargo_urgent: "緊急",
	contract_page_button_start_job: "受注",
	contract_page_button_start_job_party: "グループで受注",
	contract_page_button_cancel_job: "キャンセル",

	dealership_page_title: "ディーラー",
	dealership_page_desc: "自分や従業員のためにトラックを購入",
	dealership_page_truck: "トラック",
	dealership_page_price: "価格",
	dealership_page_engine: "エンジン",
	dealership_page_power: "馬力",
	dealership_page_power_value: "{0} hp",
	dealership_page_buy_button: "購入",
	dealership_page_bottom_text: "*免責事項",

	diagnostic_page_title: "診断",
	diagnostic_page_desc: "仕事をするためにトラックを修理する(トラックページのセレクトボタンを押して対象トラックを変更可能)",
	diagnostic_page_chassi: "ボディを修理",
	diagnostic_page_engine: "エンジンを修理",
	diagnostic_page_transmission: "トランスミッションを修理",
	diagnostic_page_wheels: "ホイールを修理",
	diagnostic_page_refuel_label: "給油",

	trucks_page_title: "トラック",
	trucks_page_desc: "ここで全てのトラックを閲覧したりドライバーに割り当てできます",
	trucks_page_chassi: "ボディ",
	trucks_page_engine: "エンジン",
	trucks_page_transmission: "トランスミッション",
	trucks_page_wheels: "ホイール",
	trucks_page_fuel: "燃料",
	trucks_page_sell_button: "トラックを売却",
	trucks_page_spawn: "トラックをスポーン",
	trucks_page_remove: "選択解除",
	trucks_page_select: "トラックを選択",
	trucks_page_unlock: "このトラックをアンロックするには、<b>レベル {0}</b> に到達してください",

	mydrivers_page_title: "ドライバー",
	mydrivers_page_desc: "ここで全てのドライバーを閲覧、トラックの設定ができます",

	drivers_page_title: "人材派遣会社",
	drivers_page_desc: "新規ドライバーの採用",
	drivers_page_hiring_price: "価格: {0}",
	drivers_page_skills: "スキル",
	drivers_page_product_type: "製品の種類",
	drivers_page_distance: "距離",
	drivers_page_valuable: "高額貨物",
	drivers_page_fragile: "割れ物",
	drivers_page_urgent: "緊急",
	drivers_page_hire_button: "雇用",
	drivers_page_driver_fuel: "燃料",
	drivers_page_fire_button: "ドライバーを解雇",
	drivers_page_refuel_button: "{0} トラックを給油",
	drivers_page_pick_truck: "トラックを選択",

	skills_page_title: "スキル",
	skills_page_desc: "働けば働くほど、貴重な経験を積むことができる。そして走行距離が増えれば増えるほど、得られる経験も増える。得た経験からスキルポイントを獲得し、割り振ることでトラック運転スキルを際立たせることができます(利用可能なスキルポイント: {0})",
	skills_page_description: "スキル説明",
	skills_page_product_type_title: "ADR (危険物)",
	skills_page_product_type_description: `
		<p>危険物の輸送には十分な訓練を受けた専門家が必要です。ADR証明書を取得し、新たなタイプの貨物輸送をアンロックします</p>
		<ul>
			Class 1 - 爆発物:
			<li> ダイナマイト、花火、弾薬など </li>
			<BR> Class 2 - ガス:
			<li> 可燃性、不燃性、有毒ガスなど、吸入すると死に至るか重傷を負う可能性があるもの </li>
			<BR> Class 3 - 可燃性液体:
			<li> ガソリン、軽油、灯油などの危険な燃料 </li>
			<BR> Class 4 - 可燃性固体:
			<li> ニトロセルロース、マグネシウム、紙マッチ、自然発火アルミニウム、白リンなどの可燃性固体 </li>
			<BR> Class 5 - 有害物質
			<li> 人体に有害な物質。例としてシアン化カリウム、塩化水銀、殺虫剤など。 </li>
			<BR> Class 6 - 腐食物質
			<li> 有機物を溶かしたり、特定の金属をひどく腐食させてしまう物質。例として硫酸、塩酸、水酸化カリウム、水酸化ナトリウムが挙げられる </li>
		</ul>`,
	skills_page_distance_title: "距離",
	skills_page_distance_description: `
		<p> 長距離運送スキルによって受注可能な最長距離が決まる。最初は6km以上の運転は出来ない </p>
		<ul>
			Level 1:
			<li> 6.5kmまで配達距離を拡大 </li>
			<li> 6km以上の場合に5%の追加報酬 </li>
			<li> 6km以上の場合に10%の経験値ボーナス </li>
			<BR> Level 2:
			<li> 7kmまで配達距離を拡大 </li>
			<li> 6.5km以上の場合に10%の追加報酬 </li>
			<BR> Level 3:
			<li> 7.5kmまで配達距離を拡大 </li>
			<li> 7km以上の場合に15%の追加報酬 </li>
			<BR> Level 4:
			<li> 8kmまで配達距離を拡大 </li>
			<li> 7.5km以上の場合に20%の追加報酬 </li>
			<BR> Level 5:
			<li> 8.5kmまで配達距離を拡大 </li>
			<li> 8km以上の場合に25%の追加報酬 </li>
			<BR> Level 6:
			<li> 配達距離を無制限に拡大 </li>
			<li> 8.5km以上の場合に30%の追加報酬 </li>
		</ul>`,
	skills_page_valuable_title: "貴重品",
	skills_page_valuable_desc: `
		<p> どの貨物も価値あるものだが、それらよりも価値の高いものもある。企業はこの種の貨物を届けるのにふさわしい実績を持った専門家だけを頼りにします </p>
		<ul>
			Level 1:
			<li> 貴重な貨物の受注をアンロック </li>
			<li> 貴重な貨物を運んだ場合に5%の追加報酬 </li>
			<li> 貴重な貨物を運んだ場合に20%の経験値ボーナス </li>
			<BR> Level 2:
			<li> 貴重な貨物を運んだ場合に10%の追加報酬 </li>
			<BR> Level 3:
			<li> 貴重な貨物を運んだ場合に15%の追加報酬 </li>
			<BR> Level 4:
			<li> 貴重な貨物を運んだ場合に20%の追加報酬 </li>
			<BR> Level 5:
			<li> 貴重な貨物を運んだ場合に25%の追加報酬 </li>
			<BR> Level 6:
			<li> 貴重な貨物を運んだ場合に30%の追加報酬 </li>
		</ul>`,
	skills_page_fragile_title: "割れ物",
	skills_page_fragile_desc: `
		<p> このスキルを保有することにより、ガラスや電子機器、その他デリケートな機械など壊れやすい貨物を輸送することが出来るようになる </p>
		<ul>
			Level 1:
			<li> 割れ物貨物の受注をアンロック </li>
			<li> 割れ物貨物を運んだ場合に5%の追加報酬 </li>
			<li> 割れ物貨物を運んだ場合に20%の経験値ボーナス </li>
			<BR> Level 2:
			<li> 割れ物貨物を運んだ場合に10%の追加報酬 </li>
			<BR> Level 3:
			<li> 割れ物貨物を運んだ場合に15%の追加報酬 </li>
			<BR> Level 4:
			<li> 割れ物貨物を運んだ場合に20%の追加報酬 </li>
			<BR> Level 5:
			<li> 割れ物貨物を運んだ場合に25%の追加報酬 </li>
			<BR> Level 6:
			<li> 割れ物貨物を運んだ場合に30%の追加報酬 </li>
		</ul>`,
	skills_page_fast_title: "緊急",
	skills_page_fast_desc: `
		<p> 時には、企業は何かを迅速に届ける必要がある。このような仕事はドライバーに多大なプレッシャーを与え、猶予時間も短いが、その不快感の代償として多額の報酬が支払われる </p>
		<ul>
			Level 1:
			<li> 緊急貨物の受注をアンロック </li>
			<li> 緊急貨物を運んだ場合に5%の追加報酬 </li>
			<li> 緊急貨物を運んだ場合に20%の経験値ボーナス </li>
			<BR> Level 2:
			<li> 緊急貨物を運んだ場合に10%の追加報酬 </li>
			<BR> Level 3:
			<li> 緊急貨物を運んだ場合に15%の追加報酬 </li>
			<BR> Level 4:
			<li> 緊急貨物を運んだ場合に20%の追加報酬 </li>
			<BR> Level 5:
			<li> 緊急貨物を運んだ場合に25%の追加報酬 </li>
			<BR> Level 6:
			<li> 緊急貨物を運んだ場合に30%の追加報酬 </li>
		</ul>`,

	party_page_title: "パーティー",
	party_page_desc: "パーティーを作成したり参加したりして仲間と一緒に配達しよう",
	party_page_create: "パーティーを作成",
	party_page_join: "パーティーに参加",
	party_page_name: "パーティー名*",
	party_page_subtitle: "パーティー説明*",
	party_page_password: "パスワード",
	party_page_password_confirm: "パスワード(確認)",
	party_page_members: "メンバー数*",
	party_page_finish_button: "パーティー作成 ({0} + {1})",
	party_page_finish_button_2: "パーティーに参加",
	party_page_password_mismatch: "* パスワードが正しくありません",
	party_leader: "パーティーリーダー",
	party_finished_deliveries: "パーティーでの配達完了: {0}",
	party_joined_time: "パーティー参加: {0}",
	party_kick: "パーティーから追放",
	party_quit: "パーティーから脱退",
	party_delete: "パーティーを解散",

	bank_page_title: "銀行",
	bank_page_desc: "会社の銀行口座情報",
	bank_page_withdraw: "出金",
	bank_page_deposit: "入金",
	bank_page_balance: "残高:",
	bank_page_active_loans: "アクティブなローン",

	bank_page_loan_title: "ローン",
	bank_page_loan_desc: "ローンを組んでビジネスへいち早く投資しよう!<BR>(最大借入額: {0})",
	bank_page_loan_button: "ローンを受ける",
	bank_page_loan_value_title: "借入額",
	bank_page_loan_daily_title: "返済日当たり",
	bank_page_loan_remaining_title: "残高",
	bank_page_loan_date_title: "支払い（自動引き落とし）",
	bank_page_loan_pay: "完済する",

	bank_page_loan_modal_desc: "ローンの種類を一つ選択:",
	bank_page_loan_modal_item: "（利率{0}％、{1}日以内に返済）",
	bank_page_loan_modal_submit: "ローンを受ける",

	bank_page_deposit_modal_title: "入金",
	bank_page_deposit_modal_desc: "いくら入金しますか?",
	bank_page_deposit_modal_submit: "入金",

	bank_page_withdraw_modal_title: "出金",
	bank_page_withdraw_modal_desc: "いくら出金しますか?",
	bank_page_withdraw_modal_submit: "出金",

	bank_page_modal_placeholder: "金額",
	bank_page_modal_money_available: "利用可能な資金: {0}",
	bank_page_modal_cancel: "キャンセル",

	str_fill_field:"必須項目",
	str_invalid_value:"無効な値",
	str_more_than:"{0}以上である必要があります",
	str_less_than:"{0}以下である必要があります",
};
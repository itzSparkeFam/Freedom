if (Lang == undefined) {
	var Lang = [];
}
Lang["en"] = {
	new_contracts: "New contracts each {0} min",
	top_trucker_distance_traveled: "Travelled distance: {0}km",
	top_trucker_exp: "EXP: {0}",
	sidebar_profile: "Your Profile",
	sidebar_jobs: "Quick Jobs",
	sidebar_jobs_2: "Freight Jobs",
	sidebar_skills: "Skills",
	sidebar_diagnostic: "Diagnostic",
	sidebar_dealership: "Dealership",
	sidebar_mytrucks: "Trucks",
	sidebar_driver: "Recruitment agency",
	sidebar_mydrivers: "Drivers",
	sidebar_bank: "Bank",
	sidebar_party: "Party",
	sidebar_close: "Close",

	confirmation_modal_sell_vehicle: "Are you sure you want to sell this vehicle?",
	confirmation_modal_delete_party: "Are you sure you want to delete this party?",
	confirmation_modal_loan_payoff: "Are you sure you want to pay the entire balance of {0}?",

	statistics_page_title: "Statistics",
	statistics_page_desc: "Keep track of your performance with detailed statistics. Monitor earnings, completed deliveries, driver rankings, and more to stay on top of your business",
	statistics_page_money: "Money",
	statistics_page_money_earned: "Total Money Earned",
	statistics_page_deliveries: "Finished Deliveries",
	statistics_page_distance: "Travelled Distance",
	statistics_page_exp: "Total EXP earned",
	statistics_page_skill: "Skill Points",
	statistics_page_trucks: "Trucks",
	statistics_page_drivers: "Drivers",
	statistics_page_top_truckers: "Top drivers",
	statistics_page_top_truckers_desc: "Top 10 truck drivers list in the city",

	contract_page_title: "Quick Jobs",
	contract_page_desc: "Explore various job opportunities without the need for your own truck. The company will provide you with all the necessary resources, at the cost of earning slightly less money",
	contract_page_title_freight: "Freights",
	contract_page_desc_freight: "Use your own truck to take on specialized freight jobs. Earn more by transporting a variety of goods over longer distances",
	contract_page_distance: "Distance: {0}km",
	contract_page_reward: "Reward: {0}",
	contract_page_cargo_explosive: "Explosives",
	contract_page_cargo_flammablegas: "Flammable Gases",
	contract_page_cargo_flammableliquid: "Flammable liquids",
	contract_page_cargo_flammablesolid: "Flammable solids",
	contract_page_cargo_toxic: "Toxic Substances",
	contract_page_cargo_corrosive: "Corrosive substances",
	contract_page_cargo_fragile: "Fragile cargo",
	contract_page_cargo_valuable: "Valuable cargo",
	contract_page_cargo_urgent: "Urgent cargo",
	contract_page_button_start_job: "Start Job",
	contract_page_button_start_job_party: "Start in Group",
	contract_page_button_cancel_job: "Cancel Job",

	dealership_page_title: "Dealership",
	dealership_page_desc: "Explore the truck list and find the perfect fit for you and your drivers. Invest in the right vehicle to expand your fleet and take better jobs",
	dealership_page_truck: "Truck",
	dealership_page_price: "Price",
	dealership_page_engine: "ENGINE",
	dealership_page_power: "HORSEPOWER",
	dealership_page_power_value: "{0} hp",
	dealership_page_buy_button: "BUY",
	dealership_page_bottom_text: "*Legal Disclaimer",

	diagnostic_page_title: "Diagnostic",
	diagnostic_page_desc: "Regularly maintain your truck to keep it running. Repair the essential parts to ensure your vehicle is in great conditions for your next job",
	diagnostic_page_chassi: "Fix Body",
	diagnostic_page_engine: "Fix Engine",
	diagnostic_page_transmission: "Fix Transmission",
	diagnostic_page_wheels: "Fix Wheels",
	diagnostic_page_refuel_label: "Refuel",

	trucks_page_title: "Trucks",
	trucks_page_desc: "View and manage your fleet here. Assign drivers to each truck or make changes to keep your vehicles running",
	trucks_page_chassi: "Body",
	trucks_page_engine: "Engine",
	trucks_page_transmission: "Transmission",
	trucks_page_wheels: "Wheels",
	trucks_page_fuel: "Fuel",
	trucks_page_sell_button: "Sell Truck",
	trucks_page_spawn: "Spawn Truck",
	trucks_page_remove: "Deselect",
	trucks_page_select: "Select Truck",
	trucks_page_unlock: "Reach <b>level {0}</b> to unlock this truck",

	mydrivers_page_title: "Drivers",
	mydrivers_page_desc: "Manage your drivers and assign them to trucks. Monitor their skills and fuel levels to keep your delivery operations running",

	drivers_page_title: "Recruitment Agency",
	drivers_page_desc: "Find and hire the best drivers to work for you. Consider each candidate's skills to ensure you make the best choice",
	drivers_page_hiring_price: "Price: {0}",
	drivers_page_skills: "Skills",
	drivers_page_product_type: "Product Type",
	drivers_page_distance: "Distance",
	drivers_page_valuable: "Valuable Cargo",
	drivers_page_fragile: "Fragile Cargo",
	drivers_page_urgent: "On-time delivery",
	drivers_page_hire_button: "HIRE",
	drivers_page_driver_fuel: "Fuel",
	drivers_page_fire_button: "Fire driver",
	drivers_page_refuel_button: "Refuel truck {0}",
	drivers_page_pick_truck: "Select a Truck",

	skills_page_title: "Skills",
	skills_page_desc: "As you work you gain experience. The more distance you cover, the more experience you gain. Once you level up, this earns you skill points which you can assign here to improve your trucking skills. (Skill points avaliable: {0})",
	skills_page_description: "Description",
	skills_page_product_type_title: "Product Type (ADR)",
	skills_page_product_type_description: `
		<p>The transport of dangerous goods requires well-trained professionals. Purchase ADR certificates to unlock new types of cargo.</p>
		<ul>
			Class 1 - Explosives:
			<li>Such as as dynamite, fireworks or ammunition</li>
			<BR> Class 2 - Gases:
			<li> Flammable, non-flammable and poisonous gases that may cause death ot serious injury if inhaled </li>
			<BR> Class 3 - Flammable liquids:
			<li> Dangerous fuels such as gasoline, diesel and kerosene </li>
			<BR> Class 4 - Flammable solids:
			<li> Flammable solids like nitrocellulose, magnesium, safety matches, spontaneous combustion aluminum, white phosphorus, among others </li>
			<BR> Class 6 - Toxic Substances
			<li> Poisons, substances harmful to human health, for instance, potassium cyanide, mercury chloride and pesticides </li>
			<BR> Class 8 - Corrosive substances
			<li> Substances that can dissolve organic tissue or severely corrode certain metals. As example could be named sulfuric acid, hydrochloric acid, potassium hydroxide and sodium hydroxide </li>
		</ul>`,
	skills_page_distance_title: "Distance",
	skills_page_distance_description: `
		<p> Your long distance skill determines the maximum distance you can travel on duty. Initially they are not offered to drive more than 6km. </p>
		<ul>
			Level 1:
			<li> Deliveries up to 6.5km </li>
			<li> 5% reward for distances greater than 6km </li>
			<li> 10% experience bonus for distances greater than 6km </li>
			<BR> Level 2:
			<li> Deliveries up to 7km </li>
			<li> 10% reward for distances greater than 6.5km </li>
			<BR> Level 3:
			<li> Deliveries up to 7.5km </li>
			<li> 15% reward for distances greater than 7km </li>
			<BR> Level 4:
			<li> Deliveries up to 8km </li>
			<li> 20% reward for distances greater than 7.5km </li>
			<BR> Level 5:
			<li> Deliveries up to 8.5km </li>
			<li> 25% reward for distances greater than 8km </li>
			<BR> Level 6:
			<li> Deliveries anywhere </li>
			<li> 30% reward for distances greater than 8.5km </li>
		</ul>`,
	skills_page_valuable_title: "Valuable Cargo",
	skills_page_valuable_desc: `
		<p> Every cargo is valuable, but some are more valuable than others. Companies rely only on proven specialists to perform this type of service. </p>
		<ul>
			Level 1:
			<li> High value unlocked job offers </li>
			<li> 5% reward for valuable deliveries </li>
			<li> 20% experience bonus for valuable deliveries </li>
			<BR> Level 2:
			<li> 10% reward for valuable deliveries </li>
			<BR> Level 3:
			<li> 15% reward for valuable deliveries </li>
			<BR> Level 4:
			<li> 20% reward for valuable deliveries </li>
			<BR> Level 5:
			<li> 25% reward for valuable deliveries </li>
			<BR> Level 6:
			<li> 30% reward for valuable deliveries </li>
		</ul>`,
	skills_page_fragile_title: "Fragile Cargo",
	skills_page_fragile_desc: `
		<p> This ability allows you to transport fragile loads, such as glass, electronics or delicate machines. </p>
		<ul>
			Level 1:
			<li> Fragile cargo job offers unlocked </li>
			<li> 5% reward for fragile cargo deliveries </li>
			<li> 20% experience bonus for fragile cargo deliveries </li>
			<BR> Level 2:
			<li> 10% reward for delivery of fragile cargo </li>
			<BR> Level 3:
			<li> 15% reward for deliveries of fragile cargo </li>
			<BR> Level 4:
			<li> 20% reward for delivery of fragile cargo </li>
			<BR> Level 5:
			<li> 25% reward for delivery of fragile cargo </li>
			<BR> Level 6:
			<li> 30% reward for fragile cargo deliveries </li>
		</ul>`,
	skills_page_fast_title: "On-time delivery",
	skills_page_fast_desc: `
		<p> Sometimes, companies need to deliver something quickly. These jobs put more pressure on the driver, the delivery time is short but the payment makes up for the discomfort. </p>
		<ul>
			Level 1:
			<li> Urgent cargo job offers </li>
			<li> 5% reward for urgent cargo deliveries </li>
			<li> 20% experience bonus for urgent cargo deliveries </li>
			<BR> Level 2:
			<li> 10% reward for urgent cargo deliveries </li>
			<BR> Level 3:
			<li> 15% reward for urgent cargo deliveries </li>
			<BR> Level 4:
			<li> 20% reward for urgent cargo deliveries </li>
			<BR> Level 5:
			<li> 25% reward for urgent cargo deliveries </li>
			<BR> Level 6:
			<li> 30% reward for urgent cargo deliveries </li>
		</ul>`,

	party_page_title: "Party",
	party_page_desc: "Team up with friends to do deliveries together. Create or join a party to make the jobs more fun and profitable.",
	party_page_create: "Create party",
	party_page_join: "Join party",
	party_page_name: "Party name*",
	party_page_subtitle: "Party description*",
	party_page_password: "Password",
	party_page_password_confirm: "Confirm Password",
	party_page_members: "Members amount*",
	party_page_finish_button: "Create party ({0} + {1})",
	party_page_finish_button_2: "Join party",
	party_page_password_mismatch: "* Password mismatch",
	party_leader: "Party leader",
	party_finished_deliveries: "Deliveries completed on party: {0}",
	party_joined_time: "In the party since: {0}",
	party_kick: "Kick party",
	party_quit: "Quit party",
	party_delete: "Delete party",

	bank_page_title: "Bank",
	bank_page_desc: "View your company's bank account information here",
	bank_page_withdraw: "Withdraw money",
	bank_page_deposit: "Deposit Money",
	bank_page_balance: "Your balance is:",
	bank_page_active_loans: "Active loans",

	bank_page_loan_title: "Loans",
	bank_page_loan_desc: "Take out loans to invest in your business!<BR>(Maximum loan: {0})",
	bank_page_loan_button: "Take loan",
	bank_page_loan_value_title: "Loan amount",
	bank_page_loan_daily_title: "Daily cost",
	bank_page_loan_remaining_title: "Remaining amount",
	bank_page_loan_date_title: "Next payment (Auto-Debit)",
	bank_page_loan_pay: "Payoff Loan",

	bank_page_loan_modal_desc: "Select one of the loan types:",
	bank_page_loan_modal_item: "({0}% interest rate, repayable in {1} days)",
	bank_page_loan_modal_submit: "Take loan",

	bank_page_deposit_modal_title: "Deposit money",
	bank_page_deposit_modal_desc: "How much do you want to deposit?",
	bank_page_deposit_modal_submit: "Deposit money",

	bank_page_withdraw_modal_title: "Withdraw money",
	bank_page_withdraw_modal_desc: "How much do you want to withdraw?",
	bank_page_withdraw_modal_submit: "Withdraw money",

	bank_page_modal_placeholder: "Amount",
	bank_page_modal_money_available: "Available money: {0}",
	bank_page_modal_cancel: "Cancel",

	str_fill_field:"Fill this field",
	str_invalid_value:"Invalid value",
	str_more_than:"Must be greater than or equal to {0}",
	str_less_than:"Must be less than or equal to {0}",
};
function user_job_setup()
	-- Options: Override default values
    state.OffenseMode:options('Normal','SomeAcc','Acc','FullAcc','Fodder')
    state.WeaponskillMode:options('Match','Normal','SomeAcc','Acc','FullAcc','Fodder')
    state.HybridMode:options('Normal', 'PDT','MDT')
    state.PhysicalDefenseMode:options('PDT', 'PDTReraise')
    state.MagicalDefenseMode:options('MDT', 'MDTReraise')
	state.ResistDefenseMode:options('MEVA')
	state.IdleMode:options('Normal', 'PDT','Refresh','Reraise')
    state.ExtraMeleeMode = M{['description']='Extra Melee Mode','None'}
	state.Passive = M{['description'] = 'Passive Mode','None','Twilight'}
	state.Weapons:options('Chango','Axe','AxeFencer','Sword','SwordFencer','Greatsword','HandToHand','Polearm','ProcDagger','ProcSword','ProcGreatSword','ProcScythe','ProcPolearm','ProcGreatKatana','ProcClub','ProcStaff','ProcKatana')

	-- gear.da_jse_back = {name="Cichol's Mantle",augments={'DEX+20','Accuracy+20 Attack+20','"Dbl.Atk."+10'}}
	-- gear.crit_jse_back = {name="Cichol's Mantle",augments={'STR+20','Accuracy+20 Attack+20','Crit.hit rate+10'}}

	gear.tp_jse_back = { name="Cichol's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Dbl.Atk."+10','Phys. dmg. taken-10%',}}
	gear.ws_jse_back = {name="Cichol's Mantle",augments={'STR+20','Accuracy+20 Attack+20','STR+10','Weapon skill damage +10%','Magic dmg. taken-10%'}}
	gear.vit_jse_back = {name="Cichol's Mantle",augments={'VIT+20','Accuracy+20 Attack+20','VIT+10','Weapon skill damage +10%',}}
	
	gear.odyssean_ws_vit_hands = {name="Odyssean Gauntlets", augments={'Weapon skill damage +4%','VIT+15',}}
	gear.odyssean_ws_str_hands = {name="Odyssean Gauntlets", augments={'Weapon skill damage +5%','STR+6','Accuracy+3','Attack+9',}}
	gear.odyssean_ws_vit_legs = {name="Odyssean Cuisses", augments={'Accuracy+9','Weapon skill damage +4%','VIT+13','Attack+13',}}
	
	gear.odyssean_fc_legs = { name="Odyssean Cuisses", augments={'"Fast Cast"+5','MND+10','Accuracy+12','Attack+11',}}
	gear.odyssean_fc_helm = { name="Odyssean Helm", augments={'"Fast Cast"+5','STR+8','Accuracy+10',}}
	gear.odyssean_fc_feet = { name="Odyssean Greaves", augments={'Accuracy+14','"Fast Cast"+5','VIT+5','Attack+1',}}
	gear.odyssean_fc_body = { name="Odyss. Chestplate", augments={'Accuracy+16','"Fast Cast"+5','DEX+10','Attack+13',}}
	
	gear.odyssean_TH_legs = { name="Odyssean Cuisses", augments={'STR+2','Damage taken-1%','"Treasure Hunter"+2','Accuracy+11 Attack+11',}}
	
	gear.valorous_ws_str_legs = {name="Valorous Hose", augments={'Accuracy+27','Weapon skill damage +3%','STR+12',}}
	gear.valorous_ws_crit_feet ={ name="Valorous Greaves", augments={'Attack+28','Crit.hit rate+3','STR+13','Accuracy+8',}}
	
	gear.valorous_TH_hands = {name="Valorous Mitts", augments={'VIT+2','AGI+3','Treasure Hunter +1'}}
	
	gear.tp_hands = {name="Emicho Gauntlets +1"}
	gear.tp_earring = {name="Suppanomimi"}

	-- gear.tp_hands = {name="Sulev. Gauntlets +2"}
	-- gear.tp_earring = {name="Cessance Earring"}
	
	-- gear.tp_earring = {name="Dedition Earring"}

	-- ! = alt, ^ = ctrl, @ = windows key
	-- Additional local binds
	send_command('bind ^` input /ja "Hasso" <me>')
	send_command('bind !` input /ja "Seigan" <me>')
	send_command('bind @` gs c cycle SkillchainMode')
	send_command('bind !r gs c cycle weapons;gs c update')
	
	select_default_macro_book()
end

-- Define sets and vars used by this job file.
function init_gear_sets()
	--------------------------------------
	-- Start defining the sets
	--------------------------------------
	-- Precast Sets
	
    sets.Enmity = {ammo="Paeapua",
        head="Souv. Schaller +1",neck="Moonbeam Necklace",ear1="Friomisi Earring",ear2="Odnowa Earring +1",
        body="Souv. Cuirass +1",hands="Souv. Handsch. +1",ring1="Apeile Ring +1",ring2="Provocare Ring",
        back="Moonbeam Cape",legs="Souv. Diechlings +1",feet="Souveran Schuhs +1"}
	sets.Knockback = {}
	sets.passive.Twilight = {head="Twilight Helm",body="Twilight Mail"}
	
	sets.TreasureHunter = {hands="Volte Bracers", legs=gear.odyssean_TH_legs}
	
	-- Precast sets to enhance JAs
	sets.precast.JA['Berserk'] = {body="Pumm. Lorica +3"}
	sets.precast.JA['Warcry'] = {head="Agoge Mask +3"}
	sets.precast.JA['Defender'] = {}
	sets.precast.JA['Aggressor'] = {body="Agoge Lorica +3"}
	sets.precast.JA['Mighty Strikes'] = {hands="Agoge Mufflers +1"}
	sets.precast.JA["Warrior's Charge"] = {}
	sets.precast.JA['Tomahawk'] = {ammo="Thr. Tomahawk"}
	sets.precast.JA['Retaliation'] = {}
	sets.precast.JA['Restraint'] = {}
	sets.precast.JA['Blood Rage'] = {}
	sets.precast.JA['Brazen Rush'] = {}
	sets.precast.JA['Provoke'] = set_combine(sets.Enmity,sets.TreasureHunter)
                   
	-- Waltz set (chr and vit)
	sets.precast.Waltz = {}
                   
	-- Don't need any special gear for Healing Waltz.
	sets.precast.Waltz['Healing Waltz'] = {}
           
	sets.precast.Step = {}
	
	sets.precast.Flourish1 = {}
		   
	-- Fast cast sets for spells

	sets.precast.FC = {ammo="Impatiens",
		head=gear.odyssean_fc_helm,neck="Baetyl Pendant",ear1="Enchntr. Earring +1",ear2="Loquac. Earring",
		body=gear.odyssean_fc_body,hands="Leyline Gloves",ring1="Defending Ring",ring2="Prolix Ring",
		back="Moonbeam Cape",waist="Flume Belt",legs=gear.odyssean_fc_legs,feet=gear.odyssean_fc_feet}
	
	sets.precast.FC.Utsusemi = set_combine(sets.precast.FC, {})

	-- Midcast Sets
	sets.midcast.FastRecast = {ammo="Staunch Tathlum +1",
		head=gear.odyssean_fc_helm,neck="Moonbeam Necklace",ear1="Odnowa Earring +1",ear2="Ethereal Earring",
		body=gear.odyssean_fc_body,hands="Leyline Gloves",ring1="Defending Ring",ring2="Moonlight Ring",
		back="Moonbeam Cape",waist="Tempus Fugit",legs="Founder's Hose",feet=gear.odyssean_fc_feet}
	
	sets.midcast.Utsusemi = set_combine(sets.midcast.FastRecast, {})
                   
	-- sets.midcast.Cure = {}
	
	-- sets.Self_Healing = {}
	-- sets.Cure_Received = {}
						                   
	-- Weaponskill sets
	-- Default set for any weaponskill that isn't any more specifically defined
    sets.precast.WS = {ammo="Knobkierrie", 
		head="Agoge Mask +3", neck="War. Beads +1",ear1="Moonshade Earring", ear2="Thrud Earring", 
		body="Pumm. Lorica +3", hands=gear.odyssean_ws_str_hands,ring1="Ifrit Ring",ring2="Niqmaddu Ring",
		back=gear.ws_jse_back, waist="Fotia Belt", legs=gear.valorous_ws_str_legs, feet="Sulev. Leggings +2"}

	sets.precast.WS.PDT = set_combine{sets.precast.WS, {}}
	sets.precast.WS.SomeAcc = set_combine(sets.precast.WS, {})
	sets.precast.WS.Acc = set_combine(sets.precast.WS, {})
	sets.precast.WS.FullAcc = set_combine(sets.precast.WS, {})
	sets.precast.WS.Fodder = set_combine(sets.precast.WS, {})

    -- Specific weaponskill sets.  Uses the base set if an appropriate WSMod version isn't found.	
    sets.precast.WS['Savage Blade'] = set_combine(sets.precast.WS, {ammo="Knobkierrie", 
		head="Agoge Mask +3", neck="War. Beads +1",ear1="Moonshade Earring", ear2="Thrud Earring", 
		body="Pumm. Lorica +3", hands=gear.odyssean_ws_str_hands,ring1="Ifrit Ring",ring2="Niqmaddu Ring",
		back=gear.ws_jse_back, waist="Fotia Belt", legs=gear.valorous_ws_str_legs, feet="Sulev. Leggings +2"})
    sets.precast.WS['Savage Blade'].SomeAcc = set_combine(sets.precast.WS.SomeAcc, {})
    sets.precast.WS['Savage Blade'].Acc = set_combine(sets.precast.WS.Acc, {})
    sets.precast.WS['Savage Blade'].FullAcc = set_combine(sets.precast.WS.FullAcc, {})
    sets.precast.WS['Savage Blade'].Fodder = set_combine(sets.precast.WS.Fodder, {})
	
	sets.precast.WS['Impulse Drive'] = set_combine(sets.precast.WS, {ammo="Knobkierrie", 
		head="Agoge Mask +3", neck="War. Beads +1",ear1="Moonshade Earring", ear2="Thrud Earring", 
		body="Pumm. Lorica +3", hands=gear.odyssean_ws_str_hands,ring1="Ifrit Ring",ring2="Niqmaddu Ring",
		back=gear.ws_jse_back, waist="Sailfi Belt +1", legs=gear.valorous_ws_str_legs, feet="Sulev. Leggings +2"})
    sets.precast.WS['Impulse Drive'].SomeAcc = set_combine(sets.precast.WS.SomeAcc, {})
    sets.precast.WS['Impulse Drive'].Acc = set_combine(sets.precast.WS.Acc, {})
    sets.precast.WS['Impulse Drive'].FullAcc = set_combine(sets.precast.WS.FullAcc, {})
    sets.precast.WS['Impulse Drive'].Fodder = set_combine(sets.precast.WS.Fodder, {})
	

    sets.precast.WS['Upheaval'] = set_combine(sets.precast.WS, {ammo="Knobkierrie", 
		head="Agoge Mask +3", neck="War. Beads +1",ear1="Moonshade Earring", ear2="Thrud Earring", 
		body="Pumm. Lorica +3", hands=gear.odyssean_ws_vit_hands,ring1="Gelatinous Ring +1",ring2="Niqmaddu Ring",
		back=gear.vit_jse_back, waist="Sailfi Belt +1", legs=gear.odyssean_ws_vit_legs, feet="Sulev. Leggings +2"})
    sets.precast.WS['Upheaval'].SomeAcc = set_combine(sets.precast.WS.SomeAcc, {})
    sets.precast.WS['Upheaval'].Acc = set_combine(sets.precast.WS.Acc, {})
    sets.precast.WS['Upheaval'].FullAcc = set_combine(sets.precast.WS.FullAcc, {})
    sets.precast.WS['Upheaval'].Fodder = set_combine(sets.precast.WS.Fodder, {})
     
    sets.precast.WS['Resolution'] = set_combine(sets.precast.WS, {})
    sets.precast.WS['Resolution'].SomeAcc = set_combine(sets.precast.WS.SomeAcc, {})
    sets.precast.WS['Resolution'].Acc = set_combine(sets.precast.WS.Acc, {})
    sets.precast.WS['Resolution'].FullAcc = set_combine(sets.precast.WS.FullAcc, {})
    sets.precast.WS['Resolution'].Fodder = set_combine(sets.precast.WS.Fodder, {})
	
    sets.precast.WS['Ruinator'] = set_combine(sets.precast.WS, {})
    sets.precast.WS['Ruinator'].SomeAcc = set_combine(sets.precast.WS.SomeAcc, {})
    sets.precast.WS['Ruinator'].Acc = set_combine(sets.precast.WS.Acc, {})
    sets.precast.WS['Ruinator'].FullAcc = set_combine(sets.precast.WS.FullAcc, {})
    sets.precast.WS['Ruinator'].Fodder = set_combine(sets.precast.WS.Fodder, {})
	
    sets.precast.WS['Rampage'] = set_combine(sets.precast.WS, {})
    sets.precast.WS['Rampage'].SomeAcc = set_combine(sets.precast.WS.SomeAcc, {})
    sets.precast.WS['Rampage'].Acc = set_combine(sets.precast.WS.Acc, {})
    sets.precast.WS['Rampage'].FullAcc = set_combine(sets.precast.WS.FullAcc, {})
    sets.precast.WS['Rampage'].Fodder = set_combine(sets.precast.WS.Fodder, {})
	
    sets.precast.WS['Raging Rush'] = set_combine(sets.precast.WS, {})
    sets.precast.WS['Raging Rush'].SomeAcc = set_combine(sets.precast.WS.SomeAcc, {})
    sets.precast.WS['Raging Rush'].Acc = set_combine(sets.precast.WS.Acc, {})
    sets.precast.WS['Raging Rush'].FullAcc = set_combine(sets.precast.WS.FullAcc, {})
    sets.precast.WS['Raging Rush'].Fodder = set_combine(sets.precast.WS.Fodder, {})
	
    sets.precast.WS["Ukko's Fury"] = set_combine(sets.precast.WS, {ammo="Yetshila +1",
		head="Blistering Sallet +1", neck="War. Beads +1", ear1="Moonshade Earring", ear2="Thrud Earring",
		body="Hjarrandi Breast.",hands="Flam. Manopolas +2",ring1="Flamma Ring",ring2="Niqmaddu Ring",
		back=gear.ws_jse_back, waist="Sailfi Belt +1",legs="Zoar Subligar +1", feet=gear.valorous_ws_crit_feet})
    sets.precast.WS["Ukko's Fury"].SomeAcc = set_combine(sets.precast.WS.SomeAcc, {})
    sets.precast.WS["Ukko's Fury"].Acc = set_combine(sets.precast.WS.Acc, {})
    sets.precast.WS["Ukko's Fury"].FullAcc = set_combine(sets.precast.WS.FullAcc, {})
    sets.precast.WS["Ukko's Fury"].Fodder = set_combine(sets.precast.WS.Fodder, {})
	
    sets.precast.WS["King's Justice"] = set_combine(sets.precast.WS, {})
    sets.precast.WS["King's Justice"].SomeAcc = set_combine(sets.precast.WS.SomeAcc, {})
    sets.precast.WS["King's Justice"].Acc = set_combine(sets.precast.WS.Acc, {})
    sets.precast.WS["King's Justice"].FullAcc = set_combine(sets.precast.WS.FullAcc, {})
    sets.precast.WS["King's Justice"].Fodder = set_combine(sets.precast.WS.Fodder, {})
	
    sets.precast.WS["Full Break"] = set_combine(sets.precast.WS, {ammo="Pemphredo Tathlum",
		head="Flam. Zucchetto +2",neck="Moonbeam Necklace",ear1="Digni. Earring", ear2="Hermetic Earring",
		body="Flamma Korazin +2",hands="Flam. Manopolas +2",ring1="Stikini Ring",ring2="Stikini Ring",
		back=gear.ws_jse_back,waist="Eschan Stone",legs="Flamma Dirs +2",feet="Flam. Gambieras +2"})
    sets.precast.WS["Full Break"].SomeAcc = set_combine(sets.precast.WS.SomeAcc, {})
    sets.precast.WS["Full Break"].Acc = set_combine(sets.precast.WS.Acc, {})
    sets.precast.WS["Full Break"].FullAcc = set_combine(sets.precast.WS.FullAcc, {})
    sets.precast.WS["Full Break"].Fodder = set_combine(sets.precast.WS.Fodder, {})
	
	sets.precast.WS["Fell Cleave"] = set_combine({ammo="Knobkierrie", 
		head="Agoge Mask +3", neck="War. Beads +1",ear1="Moonshade Earring", ear2="Thrud Earring", 
		body="Pumm. Lorica +3", hands=gear.odyssean_ws_str_hands,ring1="Ifrit Ring",ring2="Niqmaddu Ring",
		back=gear.ws_jse_back, waist="Fotia Belt", legs=gear.valorous_ws_str_legs, feet="Sulev. Leggings +2"},sets.TreasureHunter)
	
	sets.precast.WS["Decimation"] = set_combine(sets.precast.WS, {ammo="Seething Bomblet +1",
		head="Flam. Zucchetto +2",neck="Fotia Gorget",ear1="Brutal Earring",ear2="Cessance Earring",
		body="Argosy Hauberk +1",hands="Argosy Mufflers +1",ring1="Flamma Ring",ring2="Niqmaddu Ring",
		back=gear.ws_jse_back,waist="Fotia Belt",legs="Argosy Breeches +1",feet="Flam. Gambieras +2"})
    sets.precast.WS["Decimation"].SomeAcc = set_combine(sets.precast.WS.SomeAcc, {})
    sets.precast.WS["Decimation"].Acc = set_combine(sets.precast.WS.Acc, {})
    sets.precast.WS["Decimation"].FullAcc = set_combine(sets.precast.WS.FullAcc, {})
    sets.precast.WS["Decimation"].Fodder = set_combine(sets.precast.WS.Fodder, {})

	-- Swap to these on Moonshade using WS if at 3000 TP
	sets.MaxTP = {ear1="Lugra Earring +1",ear2="Lugra Earring",}
	sets.AccMaxTP = {ear1="Mache Earring +1",ear2="Telos Earring"}
	sets.AccDayMaxTPWSEars = {ear1="Mache Earring +1",ear2="Telos Earring"}
	sets.DayMaxTPWSEars = {ear1="Thrud Earring",ear2="Brutal Earring",}
	sets.AccDayWSEars = {ear1="Mache Earring +1",ear2="Telos Earring"}
	sets.DayWSEars = {ear1="Brutal Earring",ear2="Moonshade Earring"}
	
	--Specialty WS set overwrites.
	sets.AccWSMightyCharge = {}
	sets.AccWSCharge = {}
	sets.AccWSMightyCharge = {}
	sets.WSMightyCharge = {}
	sets.WSCharge = {}
	sets.WSMighty = {}

     -- Sets to return to when not performing an action.
           
     -- Resting sets
     sets.resting = {}
           
	-- Idle sets
	sets.idle = {ammo="Staunch Tathlum +1",
		head="Hjarrandi Helm",neck="Loricate Torque +1",ear1="Genmei Earring",ear2="Ethereal Earring",
		body="Hjarrandi Breast.",hands="Sulev. Gauntlets +2",ring1="Defending Ring",ring2="Shneddick Ring",
		back=gear.tp_jse_back,waist="Flume Belt",legs="Sulevi. Cuisses +1",feet="Sulev. Leggings +2"}
		
	sets.idle.Town = {ammo="Aurgelmir Orb +1",
		head="Hjarrandi Helm",neck="War. Beads +1",ear1="Telos Earring",ear2=gear.tp_earring,
		body="Hjarrandi Breast.",hands=gear.tp_hands,ring1="Niqmaddu Ring",ring2="Shneddick Ring",
		back=gear.tp_jse_back,waist="Ioskeha Belt +1",legs="Pumm. Cuisses +3",feet="Pumm. Calligae +3"}
	
	sets.idle.Weak = set_combine(sets.idle, {head="Twilight Helm",body="Twilight Mail"})
		
	sets.idle.Reraise = set_combine(sets.idle, {head="Twilight Helm",body="Twilight Mail"})
	
	-- Defense sets
	sets.defense.PDT = {ammo="Staunch Tathlum +1",
		head="Hjarrandi Helm",neck="Loricate Torque +1",ear1="Genmei Earring",ear2="Ethereal Earring",
		body="Hjarrandi Breast.",hands="Sulev. Gauntlets +2",ring1="Defending Ring",ring2="Gelatinous Ring +1",
		back=gear.tp_jse_back,waist="Flume Belt",legs="Sulevi. Cuisses +1",feet="Sulev. Leggings +2"}
			
	sets.defense.PDTReraise = set_combine(sets.defense.PDT, {head="Twilight Helm",body="Twilight Mail"})
	
	-- sets.defense.PDTHybrid = {ammo="Staunch Tathlum +1",
		-- head="Flam. Zucchetto +2",neck="Loricate Torque +1",ear1="Ethereal Earring",ear2=gear.tp_earring,
		-- body="Valorous Mail",hands=gear.tp_hands,ring1="Defending Ring",ring2="Moonlight Ring",
		-- back=gear.tp_jse_back,waist="Flume Belt",legs="Pumm. Cuisses +3",feet="Pumm. Calligae +3"}

	sets.defense.MDT = {ammo="Staunch Tathlum +1",
		head="Hjarrandi Helm",neck="Loricate Torque +1",ear1="Genmei Earring",ear2="Ethereal Earring",
		body="Sulevia's Plate. +1",hands="Sulev. Gauntlets +2",ring1="Defending Ring",ring2="Moonlight Ring",
		back=gear.ws_jse_back,waist="Flume Belt",legs="Sulevi. Cuisses +1",feet="Sulev. Leggings +2"}
	
	sets.defense.MDTReraise = set_combine(sets.defense.MDT, {head="Twilight Helm",body="Twilight Mail"})
		
	sets.defense.MEVA = {ammo="Staunch Tathlum +1",
		head="Hjarrandi Helm",neck="Loricate Torque +1",ear1="Genmei Earring",ear2="Ethereal Earring",
		body="Sulevia's Plate. +1",hands="Sulev. Gauntlets +2",ring1="Defending Ring",ring2="Moonlight Ring",
		back=gear.ws_jse_back,waist="Flume Belt",legs="Sulevi. Cuisses +1",feet="Sulev. Leggings +2"}

	sets.Kiting = {}
	sets.Reraise = {head="Twilight Helm",body="Twilight Mail"}
	sets.buff.Doom = set_combine(sets.buff.Doom, {})
	sets.buff.Sleep = {head="Frenzy Sallet"}
     
    -- Engaged sets 
	sets.engaged = {ammo="Aurgelmir Orb +1",
		head="Hjarrandi Helm",neck="War. Beads +1",ear1="Brutal Earring",ear2=gear.tp_earring,
		body="Agoge Lorica +3",hands=gear.tp_hands,ring1="Niqmaddu Ring",ring2="Chirich Ring +1",
		back=gear.tp_jse_back,waist="Ioskeha Belt +1",legs="Pumm. Cuisses +3",feet="Pumm. Calligae +3"}
    sets.engaged.SomeAcc = {ammo="Aurgelmir Orb +1",
		head="Flam. Zucchetto +2",neck="War. Beads +1",ear1="Telos Earring",ear2=gear.tp_earring,
		body="Valorous Mail",hands=gear.tp_hands,ring1="Niqmaddu Ring",ring2="Moonlight Ring",
		back=gear.tp_jse_back,waist="Ioskeha Belt +1",legs="Pumm. Cuisses +3",feet="Pumm. Calligae +3"}
	sets.engaged.Acc = {ammo="Aurgelmir Orb +1",
		head="Hjarrandi Helm",neck="War. Beads +1",ear1="Telos Earring",ear2=gear.tp_earring,
		body="Agoge Lorica +3",hands=gear.tp_hands,ring1="Niqmaddu Ring",ring2="Moonlight Ring",
		back=gear.tp_jse_back,waist="Ioskeha Belt +1",legs="Pumm. Cuisses +3",feet="Pumm. Calligae +3"}
    sets.engaged.FullAcc = {ammo="Aurgelmir Orb +1",
		head="Flam. Zucchetto +2",neck="War. Beads +1",ear1="Telos Earring",ear2="Mache Earring +1",
		body="Agoge Lorica +3",hands=gear.tp_hands,ring1="Niqmaddu Ring",ring2="Chirich Ring +1",
		back=gear.tp_jse_back,waist="Ioskeha Belt +1",legs="Pumm. Cuisses +3",feet="Pumm. Calligae +3"}
    sets.engaged.Fodder = {ammo="Aurgelmir Orb +1",
		head="Flam. Zucchetto +2",neck="War. Beads +1",ear1="Telos Earring",ear2="Cessance Earring",
		body="Valorous Mail",hands=gear.tp_hands,ring1="Niqmaddu Ring",ring2="Chirich Ring +1",
		back=gear.tp_jse_back,waist="Ioskeha Belt +1",legs="Pumm. Cuisses +3",feet="Pumm. Calligae +3"}
		
	sets.engaged.PDT = {ammo="Aurgelmir Orb +1",
		head="Hjarrandi Helm",neck="War. Beads +1",ear1="Telos Earring",ear2=gear.tp_earring,
		body="Hjarrandi Breast.",hands=gear.tp_hands,ring1="Niqmaddu Ring",ring2="Defending Ring",
		back=gear.tp_jse_back,waist="Ioskeha Belt +1",legs="Pumm. Cuisses +3",feet="Pumm. Calligae +3"}
	sets.engaged.MDT = {ammo="Aurgelmir Orb +1",
		head="Hjarrandi Helm",neck="War. Beads +1",ear1="Telos Earring",ear2=gear.tp_earring,
		body="Hjarrandi Breast.",hands=gear.tp_hands,ring1="Niqmaddu Ring",ring2="Defending Ring",
		back=gear.ws_jse_back,waist="Ioskeha Belt +1",legs="Pumm. Cuisses +3",feet="Pumm. Calligae +3"}	
	
	--Extra Special Sets
	
	sets.buff.Doom = set_combine(sets.buff.Doom, {})
	sets.buff.Retaliation = {}
	sets.buff.Restraint = {}
	sets.TreasureHunter = set_combine(sets.TreasureHunter, {})
	
	-- Weapons sets
	sets.weapons.Chango = {main="Chango",sub="Utu Grip"}
	sets.weapons.Axe = {main="Dolichenus",sub="Zantetsuken"}
	sets.weapons.AxeFencer ={main="Dolichenus", sub="Blurred Shield +1"}
	sets.weapons.Sword = {main="Naegling",sub="Zantetsuken"}
	sets.weapons.SwordFencer = {main="Naegling",sub="Blurred Shield +1"}
	sets.weapons.Greatsword = {main="Montante +1",sub="Utu Grip"}
	sets.weapons.HandToHand = {main="Karambit"}
	sets.weapons.Polearm = {main="Kaja Lance",sub="Utu Grip"}
	sets.weapons.ProcDagger = {main="Trainee's Needle",sub=empty} --need
	sets.weapons.ProcSword = {main="Excalipoor II",sub=empty}
	sets.weapons.ProcGreatSword = {main="Claymore",sub=empty}
	sets.weapons.ProcScythe = {main="Brass Zaghnal",sub=empty}
	sets.weapons.ProcPolearm = {main="Harpoon",sub=empty}
	sets.weapons.ProcGreatKatana = {main="Hardwood Katana",sub=empty} --cant get yet
	sets.weapons.ProcClub = {main="Kitty Rod",sub=empty}
	sets.weapons.ProcStaff = {main="Ranine Staff",sub=empty}
	sets.weapons.ProcKatana = {main="Trainee's Burin",sub=empty} --need

end
	
-- Select default macro book on initial load or subjob change.
function select_default_macro_book()
    -- Default macro set/book
    if player.sub_job == 'SAM' then
        set_macro_page(1, 8)
    elseif player.sub_job == 'DNC' then
        set_macro_page(4, 8)
    elseif player.sub_job == 'THF' then
        set_macro_page(3, 8)
	elseif player.sub_job == 'NIN' then
		set_macro_page(2, 8)
    else
        set_macro_page(5, 8)
    end
end
function user_job_setup()
	-- Options: Override default values
    state.OffenseMode:options('Normal','SomeAcc','Acc','FullAcc', 'Fodder')
    state.WeaponskillMode:options('Match','Normal', 'SomeAcc', 'Acc', 'FullAcc', 'Fodder')
    state.HybridMode:options('Normal','Hybrid','DT','MEVA')
    state.PhysicalDefenseMode:options('PDT', 'HP')
	state.MagicalDefenseMode:options('MDT')
	state.ResistDefenseMode:options('MEVA')
	state.IdleMode:options('Normal')
	state.Weapons:options('Godhands','Karambit','Staff','ProcStaff','ProcClub','Barehanded','ProcSword','ProcGreatSword','ProcScythe','ProcPolearm','ProcGreatKatana')

    state.ExtraMeleeMode = M{['description']='Extra Melee Mode', 'None'}

    update_melee_groups()
	
	-- Additional local binds
	send_command('bind ^` input /ja "Boost" <me>')
	send_command('bind !` input /ja "Perfect Counter" <me>')
	send_command('bind ^backspace input /ja "Mantra" <me>')
	send_command('bind @` gs c cycle SkillchainMode')
	send_command('bind !r gs c cycle weapons;gs c update')
	
	gear.tp_jse_back = { name="Segomo's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','DEX+10','"Dbl.Atk."+10','Damage taken-5%',}}
	gear.ws_jse_back = { name="Segomo's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','Weapon skill damage +10%',}}
	
	gear.herculean_fc_head = { name="Herculean Helm", augments={'"Fast Cast"+6','Mag. Acc.+7','"Mag.Atk.Bns."+9',}}
	gear.herculean_fc_feet = {name="Herculean Boots", augments={'Mag. Acc.+9','"Fast Cast"+5','STR+9','"Mag.Atk.Bns."+6',}}
	gear.herculean_wsd_feet = {name="Herculean Boots", augments={'Weapon skill damage +3%','DEX+12','Accuracy+3',}}
	
	gear.herculean_nuke_head = { name="Herculean Helm", augments={'Weapon skill damage +2%','INT+12','Mag. Acc.+13',}}
	gear.herculean_nuke_legs = { name="Herculean Trousers", augments={'Mag. Acc.+16 "Mag.Atk.Bns."+16','Weapon skill damage +1%','INT+12','Mag. Acc.+15','"Mag.Atk.Bns."+13',}}
	gear.herculean_nuke_feet = { name="Herculean Boots", augments={'Attack+16','Weapon skill damage +2%','INT+14','Mag. Acc.+7','"Mag.Atk.Bns."+13',}}
	
	gear.herculean_crit_str_feet = { name="Herculean Boots", augments={'Accuracy+22 Attack+22','Crit. hit damage +2%','STR+15','Attack+6',}}
	gear.herculean_ta_str_feet = { name="Herculean Boots", augments={'"Triple Atk."+3','STR+14',}}
	gear.herculean_ta_dex_feet = { name="Herculean Boots", augments={'Accuracy+4 Attack+4','"Triple Atk."+3','DEX+12',}}
	
	gear.herculean_wsd_str_hands = { name="Herculean Gloves", augments={'Accuracy+28','Weapon skill damage +3%','STR+11','Attack+10',}}
	gear.herculean_ta_str_hands = {  name="Herculean Gloves", augments={'"Triple Atk."+3','STR+9','Accuracy+7',}}
	
	gear.herculean_TH_legs = { name="Herculean Trousers", augments={'Pet: MND+5','Pet: Haste+1','"Treasure Hunter"+1',}}
	gear.herculean_TH_head = { name="Herculean Helm", augments={'Rng.Acc.+13','Pet: Haste+1','"Treasure Hunter"+1','Accuracy+8 Attack+8','Mag. Acc.+7 "Mag.Atk.Bns."+7',}}
	
	select_default_macro_book()
end

function init_gear_sets()
	--------------------------------------
	-- Start defining the sets
	--------------------------------------
	
	sets.TreasureHunter = {head=gear.herculean_TH_head,hands="Volte Bracers", legs=gear.herculean_TH_legs}
	
	-- Precast Sets
	
	-- Precast sets to enhance JAs on use
	sets.precast.JA['Hundred Fists'] = {legs="Hesychast's Hose +1"}
	sets.precast.JA['Boost'] = {hands="Temple Gloves"} --hands="Anchorite's Gloves +1"
	sets.precast.JA['Boost'].OutOfCombat = {} --hands="Anchorite's Gloves +1", Remove Haste and Add Slow Gear.
	sets.precast.JA['Dodge'] = {feet="Anch. Gaiters +3"}
	sets.precast.JA['Focus'] = {head="Temple Crown"}
	sets.precast.JA['Counterstance'] = {feet="Melee Gaiters"} --feet="Hesychast's Gaiters +1"
	sets.precast.JA['Footwork'] = {feet="Shukuyu Sune-Ate"}
	sets.precast.JA['Formless Strikes'] = {body="Hesychast's Cyclas"}
	sets.precast.JA['Mantra'] = {feet="Mel. Gaiters +2"} --feet="Hesychast's Gaiters +1"

	sets.precast.JA['Chi Blast'] = set_combine(sets.TreasureHunter, {})
	sets.precast.JA['Provoke'] = set_combine(sets.Enmity,sets.TreasureHunter)
	
	sets.precast.JA['Chakra'] = {
		head="Dampening Tam",
		body="Temple Cyclas",hands="Hesychast's Gloves +1",
		legs="Hes. Hose +1",feet="Anch. Gaiters +3"}

	-- Waltz set (chr and vit)
	sets.precast.Waltz = {}
		
	-- Don't need any special gear for Healing Waltz.
	sets.precast.Waltz['Healing Waltz'] = {}

	sets.precast.Step = {ammo="Falcon Eye",
		head="Malignance Chapeau",neck="Mnk. Nodowa +1",ear1="Mache Earring +1",ear2="Telos Earring",
		body="Malignance Tabard",hands="Hesychast's Gloves +1",ring1="Ramuh Ring",ring2="Ramuh Ring",
		back="Segomo's Mantle",waist="Olseni Belt",legs="Hiza. Hizayoroi +2",feet="Malignance Boots"}
		
	sets.precast.Flourish1 = {ammo="Falcon Eye",
		head="Malignance Chapeau",neck="Mnk. Nodowa +1",ear1="Mache Earring +1",ear2="Telos Earring",
		body="Malignance Tabard",hands="Hesychast's Gloves +1",ring1="Ramuh Ring",ring2="Ramuh Ring",
		back="Segomo's Mantle",waist="Olseni Belt",legs="Mummu Kecks +2",feet="Malignance Boots"}


	-- Fast cast sets for spells
	
	sets.precast.FC = {ammo="Impatiens",
		head=gear.herculean_fc_head,neck="Baetyl Pendant",ear1="Enchntr. Earring +1",ear2="Loquac. Earring",
		body="Dread Jupon",hands="Leyline Gloves",ring1="Lebeche Ring",ring2="Prolix Ring",
		back=gear.fc_jse_back,waist="Tempus Fugit",legs="Rawhide Trousers", feet=gear.herculean_fc_feet}

	sets.precast.FC.Utsusemi = set_combine(sets.precast.FC, {neck="Magoraga Beads",body="Passion Jacket"})

       
	-- Weaponskill sets
	-- Default set for any weaponskill that isn't any more specifically defined
	sets.precast.WS = {aammo="Knobkierrie",
        head="Ken. Jinpachi +1",neck="Mnk. Nodowa +1",left_ear="Sherida Earring",right_ear="Moonshade Earring",
        body="Ken. Samue +1",hands="Adhemar Wristbands +1",ring1="Niqmaddu Ring",ring2="Gere Ring",
        back=gear.ws_jse_back,waist="Moonbow Belt +1",legs="Tatena. Haidate +1",feet=gear.herculean_ta_str_feet}
	sets.precast.WSSomeAcc = {hands="Ken. Tekko +1", left_ear="Mache Earring +1"}
	sets.precast.WSAcc = {hands="Ken. Tekko +1", left_ear="Mache Earring +1"}
	sets.precast.WSFullAcc = {hands="Ken. Tekko +1", left_ear="Mache Earring +1"}
	sets.precast.WSFodder = {}
	sets.precast.WS.SomeAcc = set_combine(sets.precast.WS, sets.precast.WSSomeAcc)	
	sets.precast.WS.Acc = set_combine(sets.precast.WS, sets.precast.WSAcc)
	sets.precast.WS.FullAcc = set_combine(sets.precast.WS, sets.precast.WSFullAcc)
	sets.precast.WS.Fodder = set_combine(sets.precast.WS, sets.precast.WSFodder)

	-- Specific weaponskill sets.

	sets.precast.WS['Raging Fists']    = set_combine(sets.precast.WS, {ammo="Knobkierrie",
        head="Ken. Jinpachi +1",neck="Mnk. Nodowa +1",left_ear="Sherida Earring",right_ear="Moonshade Earring",
        body="Adhemar Jacket +1",hands="Adhemar Wristbands +1",ring1="Niqmaddu Ring",ring2="Gere Ring",
        back=gear.ws_jse_back,waist="Moonbow Belt +1",legs="Tatena. Haidate +1",feet=gear.herculean_ta_str_feet})
	sets.precast.WS['Howling Fist']    = set_combine(sets.precast.WS, {ammo="Knobkierrie",
        head="Ken. Jinpachi +1",neck="Mnk. Nodowa +1",left_ear="Sherida Earring",right_ear="Moonshade Earring",
        body="Adhemar Jacket +1",hands=gear.herculean_ta_str_hands,ring1="Niqmaddu Ring",ring2="Gere Ring",
        back=gear.ws_jse_back,waist="Moonbow Belt +1",legs="Tatena. Haidate +1",feet=gear.herculean_ta_str_feet})
	sets.precast.WS['Asuran Fists']    = set_combine(sets.precast.WS, {hands="Anchorite's Gloves +2", waist="Fotia Belt"})
	sets.precast.WS["Ascetic's Fury"]  = set_combine(sets.precast.WS, {})
	sets.precast.WS["Victory Smite"]   = set_combine(sets.precast.WS, {ammo="Knobkierrie",
        head="Adhemar Bonnet +1",neck="Mnk. Nodowa +1",left_ear="Sherida Earring",right_ear="Odr Earring",
        body="Ken. Samue +1",hands="Ryuo Tekko +1",ring1="Niqmaddu Ring",ring2="Gere Ring",
        back=gear.ws_jse_back,waist="Moonbow Belt +1",legs="Ken. Hakama +1",feet=gear.herculean_crit_str_feet})
	sets.precast.WS['Shijin Spiral']   = set_combine(sets.precast.WS, {ammo="Knobkierrie",
        head="Malignance Chapeau",neck="Caro Necklace",ear1="Sherida Earring",ear2="Mache Earring +1",
        body="Malignance Tabard",hands="Malignance Gloves",ring1="Niqmaddu Ring",ring2="Gere Ring",
        back=gear.tp_jse_back,waist="Moonbow Belt +1",legs="Tatena. Haidate +1",feet=gear.herculean_ta_dex_feet})
	sets.precast.WS['Dragon Kick']     = set_combine(sets.precast.WS, {ammo="Knobkierrie",
        head="Ken. Jinpachi +1",neck="Mnk. Nodowa +1",left_ear="Sherida Earring",right_ear="Moonshade Earring",
        body="Adhemar Jacket +1",hands=gear.herculean_ta_str_hands,ring1="Niqmaddu Ring",ring2="Gere Ring",
        back=gear.ws_jse_back,waist="Moonbow Belt +1",legs="Tatena. Haidate +1",feet="Anch. Gaiters +3"})
	sets.precast.WS['Tornado Kick']    = set_combine(sets.precast.WS, {ammo="Knobkierrie",
        head="Ken. Jinpachi +1",neck="Mnk. Nodowa +1",left_ear="Sherida Earring",right_ear="Moonshade Earring",
        body="Adhemar Jacket +1",hands=gear.herculean_ta_str_hands,ring1="Niqmaddu Ring",ring2="Gere Ring",
        back=gear.ws_jse_back,waist="Moonbow Belt +1",legs="Tatena. Haidate +1",feet="Anch. Gaiters +3"})
	sets.precast.WS['Spinning Attack'] = set_combine(sets.precast.WS, sets.TreasureHunter)
	sets.precast.WS['Shell Crusher'] = set_combine(sets.precast.ws, {ammo="Hydrocera",
		head="Malignance Chapeau",neck="Moonbeam Necklace", left_ear="Enchntr. Earring +1",right_ear="Hermetic Earring",
        body="Malignance Tabard",hands="Malignance Gloves",ring1="Stikini Ring",ring2="Stikini Ring",
        back=gear.ws_jse_back,waist="Luminary Sash",legs="Malignance Tights",feet="Malignance Boots"})

	sets.precast.WS["Raging Fists"].SomeAcc = set_combine(sets.precast.WS["Raging Fists"], sets.precast.WSSomeAcc)
	sets.precast.WS["Howling Fist"].SomeAcc = set_combine(sets.precast.WS["Howling Fist"], sets.precast.WSSomeAcc)
	sets.precast.WS["Asuran Fists"].SomeAcc = set_combine(sets.precast.WS["Asuran Fists"], sets.precast.WSSomeAcc)
	sets.precast.WS["Ascetic's Fury"].SomeAcc = set_combine(sets.precast.WS["Ascetic's Fury"], sets.precast.WSSomeAcc, {})
	sets.precast.WS["Victory Smite"].SomeAcc = set_combine(sets.precast.WS["Victory Smite"], sets.precast.WSSomeAcc, {})
	sets.precast.WS["Shijin Spiral"].SomeAcc = set_combine(sets.precast.WS["Shijin Spiral"], sets.precast.WSSomeAcc, {})
	sets.precast.WS["Dragon Kick"].SomeAcc = set_combine(sets.precast.WS["Dragon Kick"], sets.precast.WSSomeAcc)
	sets.precast.WS["Tornado Kick"].SomeAcc = set_combine(sets.precast.WS["Tornado Kick"], sets.precast.WSSomeAcc)
	
	sets.precast.WS["Raging Fists"].Acc = set_combine(sets.precast.WS["Raging Fists"], sets.precast.WSAcc)
	sets.precast.WS["Howling Fist"].Acc = set_combine(sets.precast.WS["Howling Fist"], sets.precast.WSAcc)
	sets.precast.WS["Asuran Fists"].Acc = set_combine(sets.precast.WS["Asuran Fists"], sets.precast.WSAcc)
	sets.precast.WS["Ascetic's Fury"].Acc = set_combine(sets.precast.WS["Ascetic's Fury"], sets.precast.WSAcc, {})
	sets.precast.WS["Victory Smite"].Acc = set_combine(sets.precast.WS["Victory Smite"], sets.precast.WSAcc, {})
	sets.precast.WS["Shijin Spiral"].Acc = set_combine(sets.precast.WS["Shijin Spiral"], sets.precast.WSAcc)
	sets.precast.WS["Dragon Kick"].Acc = set_combine(sets.precast.WS["Dragon Kick"], sets.precast.WSAcc)
	sets.precast.WS["Tornado Kick"].Acc = set_combine(sets.precast.WS["Tornado Kick"], sets.precast.WSAcc)

	sets.precast.WS["Raging Fists"].FullAcc = set_combine(sets.precast.WS["Raging Fists"], sets.precast.WSFullAcc)
	sets.precast.WS["Howling Fist"].FullAcc = set_combine(sets.precast.WS["Howling Fist"], sets.precast.WSFullAcc)
	sets.precast.WS["Asuran Fists"].FullAcc = set_combine(sets.precast.WS["Asuran Fists"], sets.precast.WSFullAcc)
	sets.precast.WS["Ascetic's Fury"].FullAcc = set_combine(sets.precast.WS["Ascetic's Fury"], sets.precast.WSFullAcc, {})
	sets.precast.WS["Victory Smite"].FullAcc = set_combine(sets.precast.WS["Victory Smite"], sets.precast.WSFullAcc, {})
	sets.precast.WS["Shijin Spiral"].FullAcc = set_combine(sets.precast.WS["Shijin Spiral"], sets.precast.WSFullAcc)
	sets.precast.WS["Dragon Kick"].FullAcc = set_combine(sets.precast.WS["Dragon Kick"], sets.precast.WSFullAcc)
	sets.precast.WS["Tornado Kick"].FullAcc = set_combine(sets.precast.WS["Tornado Kick"], sets.precast.WSFullAcc)
	
	sets.precast.WS["Raging Fists"].Fodder = set_combine(sets.precast.WS["Raging Fists"], sets.precast.WSFodder)
	sets.precast.WS["Howling Fist"].Fodder = set_combine(sets.precast.WS["Howling Fist"], sets.precast.WSFodder)
	sets.precast.WS["Asuran Fists"].Fodder = set_combine(sets.precast.WS["Asuran Fists"], sets.precast.WSFodder)
	sets.precast.WS["Ascetic's Fury"].Fodder = set_combine(sets.precast.WS["Ascetic's Fury"], sets.precast.WSFodder, {})
	sets.precast.WS["Victory Smite"].Fodder = set_combine(sets.precast.WS["Victory Smite"], sets.precast.WSFodder, {})
	sets.precast.WS["Shijin Spiral"].Fodder = set_combine(sets.precast.WS["Shijin Spiral"], sets.precast.WSFodder)
	sets.precast.WS["Dragon Kick"].Fodder = set_combine(sets.precast.WS["Dragon Kick"], sets.precast.WSFodder)
	sets.precast.WS["Tornado Kick"].Fodder = set_combine(sets.precast.WS["Tornado Kick"], sets.precast.WSFodder)
	
	


	sets.precast.WS['Cataclysm'] = {ammo="Dosis Tathlum",
		neck="Baetyl Pendant",ear1="Friomisi Earring",ear2="Crematio Earring",
		hands="Malignance Gloves",ring1="Shiva Ring +1",
		back="Toro Cape",legs="Nahtirah Trousers"}
	
	-- Swap to these on Moonshade using WS if at 3000 TP
	sets.MaxTP = {ear1="Brutal Earring",ear2="Sherida Earring",}
	sets.AccMaxTP = {ear1="Mache Earring +1",ear2="Telos Earring"}
	
	-- Midcast Sets
	sets.midcast.FastRecast = {ammo="Staunch Tathlum +1",
        head=gear.herculean_fc_head,neck="Loricate Torque +1",ear1="Odnowa Earring +1",ear2="Ethereal Earring",
        body="Dread Jupon",hands="Leyline Gloves",ring1="Defending Ring",ring2="Gelatinous Ring +1",
        back="Moonbeam Cape",waist="Tempus Fugit",legs="Rawhide Trousers",feet=gear.herculean_fc_feet}
		
	-- Specific spells
	sets.midcast.Utsusemi = set_combine(sets.midcast.FastRecast, {back="Mujin Mantle"})
		
	-- Sets to return to when not performing an action.
	
	-- Resting sets
	sets.resting = {body="Hesychast's Cyclas",ring2="Sheltered Ring"}
	

	-- Idle sets
	sets.idle = {ammo="Aurgelmir Orb +1",
        head="Malignance Chapeau",neck="Mnk. Nodowa +1",ear1="Sherida Earring",ear2="Telos Earring",
        body="Malignance Tabard",hands="Malignance Gloves",ring1="Defending Ring",right_ring="Shneddick Ring",
        back=gear.tp_jse_back,waist="Moonbow Belt +1",legs="Malignance Tights",feet="Malignance Boots"}

	sets.idle.Weak = {ammo="Aurgelmir Orb +1",
        head="Malignance Chapeau",neck="Mnk. Nodowa +1",ear1="Sherida Earring",ear2="Telos Earring",
        body="Malignance Tabard",hands="Malignance Gloves",ring1="Defending Ring",right_ring="Shneddick Ring",
        back=gear.tp_jse_back,waist="Moonbow Belt +1",legs="Malignance Tights",feet="Malignance Boots"}

	sets.idle.Town = {ammo="Aurgelmir Orb +1",
        head="Malignance Chapeau",neck="Mnk. Nodowa +1",ear1="Sherida Earring",ear2="Telos Earring",
        body="Malignance Tabard",hands="Malignance Gloves",ring1="Niqmaddu Ring",ring2="Shneddick Ring",
        back=gear.tp_jse_back,waist="Moonbow Belt +1",legs="Malignance Tights",feet="Malignance Boots"}

	-- Defense sets
	sets.defense.PDT = {ammo="Staunch Tathlum +1",
        head="Malignance Chapeau",neck="Loricate Torque +1",ear1="Sherida Earring",ear2="Odnowa Earring +1",
        body="Malignance Tabard",hands="Malignance Gloves",ring1="Defending Ring",right_ring="Niqmaddu Ring",
        back=gear.tp_jse_back,waist="Flume Belt",legs="Malignance Tights",feet="Malignance Boots"}
		
	-- sets.defense.HP = {ammo="Staunch Tathlum +1",
		-- head="Genmei Kabuto",neck="Loricate Torque +1",ear1="Etiolation Earring",ear2="Sanare Earring",
		-- body="Malignance Tabard",hands="Malignance Gloves",ring1="Defending Ring",ring2="Dark Ring",
		-- back="Segomo's Mantle",waist="Black Belt",legs=gear.herculean_dt_legs,feet="Hippo. Socks +1"}

	sets.defense.MDT = {ammo="Staunch Tathlum +1",
        head="Malignance Chapeau",neck="Loricate Torque +1",ear1="Sherida Earring",ear2="Odnowa Earring +1",
        body="Malignance Tabard",hands="Malignance Gloves",ring1="Defending Ring",right_ring="Niqmaddu Ring",
        back=gear.tp_jse_back,waist="Flume Belt",legs="Malignance Tights",feet="Malignance Boots"}
		
	sets.defense.MEVA = {ammo="Staunch Tathlum +1",
        head="Ken. Jinpachi +1",neck="Loricate Torque +1",ear1="Sherida Earring",ear2="Odnowa Earring +1",
        body="Ken. Samue +1",hands="Ken. Tekko +1",ring1="Defending Ring",right_ring="Niqmaddu Ring",
        back=gear.tp_jse_back,waist="Flume Belt",legs="Ken. Hakama +1",feet="Ken. Sune-Ate +1"}

	sets.Kiting = {feet="Herald's Gaiters"}

	-- Engaged sets

	-- Variations for TP weapon and (optional) offense/defense modes.  Code will fall back on previous
	-- sets if more refined versions aren't defined.
	-- If you create a set with both offense and defense modes, the offense mode should be first.
	-- EG: sets.engaged.Dagger.Accuracy.Evasion

	-- Normal melee sets
    sets.engaged = {ammo="Aurgelmir Orb +1",
        head="Adhemar Bonnet +1",neck="Mnk. Nodowa +1",ear1="Sherida Earring",ear2="Telos Earring",
        body="Ken. Samue +1",hands="Adhemar Wristbands +1",ring1="Niqmaddu Ring",ring2="Gere Ring",
        back=gear.tp_jse_back,waist="Moonbow Belt +1",legs="Samnuha Tights",feet="Ken. Sune-Ate +1"}
    sets.engaged.SomeAcc = {ammo="Aurgelmir Orb +1",
        head="Ken. Jinpachi +1",neck="Mnk. Nodowa +1",ear1="Sherida Earring",ear2="Telos Earring",
        body="Ken. Samue +1",hands="Ken. Tekko +1",ring1="Niqmaddu Ring",ring2="Gere Ring",
        back=gear.tp_jse_back,waist="Moonbow Belt +1",legs="Ken. Hakama +1",feet="Ken. Sune-Ate +1"}
    sets.engaged.Acc = {ammo="Falcon Eye",
        head="Ken. Jinpachi +1",neck="Mnk. Nodowa +1",ear1="Sherida Earring",ear2="Telos Earring",
        body="Ken. Samue +1",hands="Ken. Tekko +1",ring1="Niqmaddu Ring",ring2="Gere Ring",
        back=gear.tp_jse_back,waist="Moonbow Belt +1",legs="Ken. Hakama +1",feet="Ken. Sune-Ate +1"}
	sets.engaged.FullAcc = {ammo="Falcon Eye",
        head="Ken. Jinpachi +1",neck="Mnk. Nodowa +1",ear1="Sherida Earring",ear2="Mache Earring +1",
        body="Ken. Samue +1",hands="Ken. Tekko +1",ring1="Niqmaddu Ring",ring2="Chirich Ring +1",
        back=gear.tp_jse_back,waist="Moonbow Belt +1",legs="Ken. Hakama +1",feet="Ken. Sune-Ate +1"}
	sets.engaged.Fodder = {ammo="Aurgelmir Orb +1",
        head="Adhemar Bonnet +1",neck="Mnk. Nodowa +1",ear1="Sherida Earring",ear2="Telos Earring",
        body="Ken. Samue +1",hands="Adhemar Wristbands +1",ring1="Niqmaddu Ring",ring2="Gere Ring",
        back=gear.tp_jse_back,waist="Moonbow Belt +1",legs="Samnuha Tights",feet="Ken. Sune-Ate +1"}

	-- Defensive melee hybrid sets
	sets.engaged.Hybrid = {ammo="Aurgelmir Orb +1",
        head="Ken. Jinpachi +1",neck="Mnk. Nodowa +1", ear1="Sherida Earring",ear2="Telos Earring",
        body="Malignance Tabard",hands="Malignance Gloves",ring1="Niqmaddu Ring",ring2="Defending Ring",
        back=gear.tp_jse_back,waist="Moonbow Belt +1",legs="Malignance Tights",feet="Ken. Sune-Ate +1"}
	
    sets.engaged.DT = {ammo="Aurgelmir Orb +1",
        head="Malignance Chapeau",neck="Mnk. Nodowa +1", ear1="Sherida Earring",ear2="Telos Earring",
        body="Malignance Tabard",hands="Malignance Gloves",ring1="Niqmaddu Ring",ring2="Defending Ring",
        back=gear.tp_jse_back,waist="Moonbow Belt +1",legs="Malignance Tights",feet="Malignance Boots"}
	
	sets.engaged.MEVA = {ammo="Aurgelmir Orb +1",
        head="Ken. Jinpachi +1",neck="Mnk. Nodowa +1",ear1="Sherida Earring",ear2="Telos Earring",
        body="Ken. Samue +1",hands="Ken. Tekko +1",ring1="Niqmaddu Ring",ring2="Defending Ring",
        back=gear.tp_jse_back,waist="Moonbow Belt +1",legs="Ken. Hakama +1",feet="Ken. Sune-Ate +1"}

	-- Hundred Fists/Impetus melee set mods
	
	sets.engaged.HF = set_combine(sets.engaged, {})
	sets.engaged.SomeAcc.HF = set_combine(sets.engaged.SomeAcc, {})
	sets.engaged.Acc.HF = set_combine(sets.engaged.Acc, {})
	sets.engaged.FullAcc.HF = set_combine(sets.engaged.FullAcc, {})
	sets.engaged.Fodder.HF = set_combine(sets.engaged.Fodder, {})

	sets.buff.Doom = {}
	sets.buff.Sleep = {head="Frenzy Sallet"}
	sets.buff.Impetus = {body="Bhikku Cyclas +1"}
	sets.buff.Footwork = {feet="Anch. Gaiters +3"}--"Shukuyu Sune-Ate"
	sets.buff.Boost = {} --waist="Ask Sash"
	
	sets.FootworkWS = {feet="Anch. Gaiters +3"}
	sets.DayIdle = {}
	sets.NightIdle = {}
    sets.Knockback = {}
	sets.TreasureHunter = set_combine(sets.TreasureHunter, {})
	sets.Skillchain = {}
	
	-- Weapons sets
	sets.weapons.Godhands = {main="Godhands"}
	sets.weapons.Karambit = {main="Karambit"}
	sets.weapons.Barehanded = {main=empty}
	sets.weapons.Staff = {main="Malignance Pole",sub="Niobid Strap"}
	sets.weapons.ProcStaff = {main="Terra's Staff"}
	sets.weapons.ProcClub = {main="Mafic Cudgel"}
	sets.weapons.ProcSword = {main="Ark Sword",sub=empty}
	sets.weapons.ProcGreatSword = {main="Lament",sub=empty}
	sets.weapons.ProcScythe = {main="Ark Scythe",sub=empty}
	sets.weapons.ProcPolearm = {main="Pitchfork +1",sub=empty}
	sets.weapons.ProcGreatKatana = {main="Hardwood Katana",sub=empty}
end

-- Select default macro book on initial load or subjob change.
function select_default_macro_book()
	-- Default macro set/book
    if player.sub_job == 'WAR' then
        set_macro_page(1, 1)
    elseif player.sub_job == 'NIN' then
        set_macro_page(2, 1)
    elseif player.sub_job == 'THF' then
        set_macro_page(3, 1)
    elseif player.sub_job == 'DNC' then
        set_macro_page(4, 1)
    else
        set_macro_page(1, 1)
    end
end
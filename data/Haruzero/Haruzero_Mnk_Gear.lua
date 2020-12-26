function user_job_setup()
	-- Options: Override default values
    state.OffenseMode:options('Normal','SomeAcc','Acc','FullAcc', 'Fodder')
    state.WeaponskillMode:options('Match','Normal', 'SomeAcc', 'Acc', 'FullAcc', 'Fodder')
    state.HybridMode:options('Normal', 'PDT')
    state.PhysicalDefenseMode:options('PDT', 'HP')
	state.MagicalDefenseMode:options('MDT')
	state.ResistDefenseMode:options('MEVA')
	state.IdleMode:options('Normal', 'PDT')
	state.Weapons:options('Godhands','Staff','ProcStaff','ProcClub','Barehanded','ProcSword','ProcGreatSword','ProcScythe','ProcPolearm','ProcGreatKatana')

    state.ExtraMeleeMode = M{['description']='Extra Melee Mode', 'None'}

    update_melee_groups()
	
	-- Additional local binds
	send_command('bind ^` input /ja "Boost" <me>')
	send_command('bind !` input /ja "Perfect Counter" <me>')
	send_command('bind ^backspace input /ja "Mantra" <me>')
	send_command('bind @` gs c cycle SkillchainMode')
	
	gear.tp_jse_back = { name="Segomo's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','DEX+10','"Dbl.Atk."+10','Damage taken-5%',}}
	gear.ws_jse_back = { name="Segomo's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','Weapon skill damage +10%',}}
	
	select_default_macro_book()
end

function init_gear_sets()
	--------------------------------------
	-- Start defining the sets
	--------------------------------------
	
	-- Precast Sets
	
	-- Precast sets to enhance JAs on use
	sets.precast.JA['Hundred Fists'] = {legs="Hesychast's Hose +1"}
	sets.precast.JA['Boost'] = {hands="Temple Gloves"} --hands="Anchorite's Gloves +1"
	sets.precast.JA['Boost'].OutOfCombat = {} --hands="Anchorite's Gloves +1", Remove Haste and Add Slow Gear.
	sets.precast.JA['Dodge'] = {feet="Temple Gaiters"}
	sets.precast.JA['Focus'] = {head="Temple Crown"}
	sets.precast.JA['Counterstance'] = {feet="Melee Gaiters"} --feet="Hesychast's Gaiters +1"
	sets.precast.JA['Footwork'] = {feet="Shukuyu Sune-Ate"}
	sets.precast.JA['Formless Strikes'] = {body="Hesychast's Cyclas"}
	sets.precast.JA['Mantra'] = {feet="Mel. Gaiters +2"} --feet="Hesychast's Gaiters +1"

	sets.precast.JA['Chi Blast'] = {}
	
	sets.precast.JA['Chakra'] = {
		head="Dampening Tam",
		body="Temple Cyclas",hands="Hesychast's Gloves +1",
		legs="Hes. Hose +1",feet="Anch. Gaiters +1"}

	-- Waltz set (chr and vit)
	sets.precast.Waltz = {}
		
	-- Don't need any special gear for Healing Waltz.
	sets.precast.Waltz['Healing Waltz'] = {}

	sets.precast.Step = {ammo="Falcon Eye",
		head="Malignance Chapeau",neck="Moonlight Nodowa",ear1="Mache Earring +1",ear2="Telos Earring",
		body="Malignance Tabard",hands="Hesychast's Gloves +1",ring1="Ramuh Ring +1",ring2="Ramuh Ring +1",
		back="Segomo's Mantle",waist="Olseni Belt",legs="Hiza. Hizayoroi +2",feet="Malignance Boots"}
		
	sets.precast.Flourish1 = {ammo="Falcon Eye",
		head="Malignance Chapeau",neck="Moonlight Nodowa",ear1="Mache Earring +1",ear2="Telos Earring",
		body="Malignance Tabard",hands="Hesychast's Gloves +1",ring1="Ramuh Ring +1",ring2="Ramuh Ring +1",
		back="Segomo's Mantle",waist="Olseni Belt",legs="Mummu Kecks +2",feet="Malignance Boots"}


	-- Fast cast sets for spells
	
	sets.precast.FC = {ammo="Impatiens",
	head=gear.herculean_fc_head,neck="Voltsurge Torque",ear1="Enchntr. Earring +1",ear2="Loquac. Earring",
	body="Dread Jupon",hands="Leyline Gloves",ring2="Lebeche Ring",ring2="Kishar Ring",
	legs="Rawhide Trousers"}

	sets.precast.FC.Utsusemi = set_combine(sets.precast.FC, {neck="Magoraga Beads",body="Passion Jacket"})

       
	-- Weaponskill sets
	-- Default set for any weaponskill that isn't any more specifically defined
	sets.precast.WS = {ammo="Aurgelmir Orb",
        head="Ken. Jinpachi +1",neck="Fotia Gorget",left_ear="Sherida Earring",right_ear="Moonshade Earring",
        body="Ken. Samue +1",hands="Adhemar Wristbands +1",ring1="Ifrit Ring",ring2="Niqmaddu Ring",
        back=gear.ws_jse_back,waist="Moonbow Belt +1",legs="Hiza. Hizayoroi +2",feet="Ken. Sune-Ate +1"}
	sets.precast.WSSomeAcc = {hands="Ken. Tekko +1", left_ear="Mache Earring +1"}
	sets.precast.WSAcc = {hands="Ken. Tekko +1", left_ear="Mache Earring +1"}
	sets.precast.WSFullAcc = {hands="Ken. Tekko +1", left_ear="Mache Earring +1"}
	sets.precast.WSFodder = {}
	sets.precast.WS.SomeAcc = set_combine(sets.precast.WS, sets.precast.WSSomeAcc)	
	sets.precast.WS.Acc = set_combine(sets.precast.WS, sets.precast.WSAcc)
	sets.precast.WS.FullAcc = set_combine(sets.precast.WS, sets.precast.WSFullAcc)
	sets.precast.WS.Fodder = set_combine(sets.precast.WS, sets.precast.WSFodder)

	-- Specific weaponskill sets.

	sets.precast.WS['Raging Fists']    = set_combine(sets.precast.WS, {head="Adhemar Bonnet +1",neck="Moonlight Nodowa"})
	sets.precast.WS['Howling Fist']    = set_combine(sets.precast.WS, {})
	sets.precast.WS['Asuran Fists']    = set_combine(sets.precast.WS, {hands="Anchorite's Gloves +2", waist="Fotia Belt"})
	sets.precast.WS["Ascetic's Fury"]  = set_combine(sets.precast.WS, {})
	sets.precast.WS["Victory Smite"]   = set_combine(sets.precast.WS, {})
	sets.precast.WS['Shijin Spiral']   = set_combine(sets.precast.WS, {ear1="Brutal Earring",ear2="Mache Earring +1"})
	sets.precast.WS['Dragon Kick']     = set_combine(sets.precast.WS, {})
	sets.precast.WS['Tornado Kick']    = set_combine(sets.precast.WS, {})
	sets.precast.WS['Spinning Attack'] = set_combine(sets.precast.WS, {})

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
		head=gear.herculean_fc_head,neck="Voltsurge Torque",ear1="Enchntr. Earring +1",ear2="Loquac. Earring",
		body="Dread Jupon",hands="Leyline Gloves",ring1="Defending Ring",ring2="Prolix Ring",
		back="Moonlight Cape",waist="Black Belt",legs=gear.herculean_dt_legs,feet="Hippo. Socks +1"}
		
	-- Specific spells
	sets.midcast.Utsusemi = set_combine(sets.midcast.FastRecast, {back="Mujin Mantle"})
		
	-- Sets to return to when not performing an action.
	
	-- Resting sets
	sets.resting = {body="Hesychast's Cyclas",ring2="Sheltered Ring"}
	

	-- Idle sets
	sets.idle = {ammo="Staunch Tathlum +1",
        head="Ken. Jinpachi +1",neck="Loricate Torque +1",ear1="Ethereal Earring",
        body="Ken. Samue +1",hands="Ken. Tekko +1",ring1="Defending Ring",right_ring="Shneddick Ring",
        back=gear.tp_jse_back,waist="Flume Belt",legs="Ken. Hakama +1",feet="Ken. Sune-Ate +1"}

	sets.idle.Weak = {ammo="Aurgelmir Orb",
        head="Ken. Jinpachi +1",neck="Loricate Torque +1",ear1="Sherida Earring",ear2="Dedition Earring",
        body="Ken. Samue +1",hands="Ken. Tekko +1",ring1="Niqmaddu Ring",ring2="Shneddick Ring",
        back=gear.tp_jse_back,waist="Flume Belt",legs="Ken. Hakama +1",feet="Ken. Sune-Ate +1"}

	sets.idle.PDT = {ammo="Staunch Tathlum +1",
        head="Ken. Jinpachi +1",neck="Loricate Torque +1",ear1="Ethereal Earring",ear2="Genmei Earring",
        body="Ken. Samue +1",hands="Ken. Tekko +1",ring1="Defending Ring",right_ring="Gelatinous Ring +1",
        back=gear.tp_jse_back,waist="Flume Belt",legs="Ken. Hakama +1",feet="Ken. Sune-Ate +1"}	

	sets.idle.Town = {ammo="Aurgelmir Orb",
        head="Adhemar Bonnet +1",neck="Moonlight Nodowa",ear1="Sherida Earring",ear2="Dedition Earring",
        body="Ken. Samue +1",hands="Adhemar Wristbands +1",ring1="Niqmaddu Ring",ring2="Shneddick Ring",
        back=gear.tp_jse_back,waist="Moonbow Belt +1",legs="Ken. Hakama +1",feet="Ken. Sune-Ate +1"}

	-- Defense sets
	sets.defense.PDT = {ammo="Staunch Tathlum +1",
        head="Ken. Jinpachi +1",neck="Loricate Torque +1", ear1="Ethereal Earring",ear2="Genmei Earring",
        body="Ken. Samue +1",hands="Ken. Tekko +1",ring1="Defending Ring",right_ring="Gelatinous Ring +1",
        back=gear.tp_jse_back,waist="Flume Belt",legs="Ken. Hakama +1",feet="Ken. Sune-Ate +1"}
		
	-- Defense sets
	-- sets.defense.HP = {ammo="Staunch Tathlum +1",
		-- head="Genmei Kabuto",neck="Loricate Torque +1",ear1="Etiolation Earring",ear2="Sanare Earring",
		-- body="Malignance Tabard",hands="Malignance Gloves",ring1="Defending Ring",ring2="Dark Ring",
		-- back="Segomo's Mantle",waist="Black Belt",legs=gear.herculean_dt_legs,feet="Hippo. Socks +1"}

	sets.defense.MDT = {ammo="Staunch Tathlum +1",
        head="Ken. Jinpachi +1",neck="Loricate Torque +1",ear1="Genmei Earring",ear2="Ethereal Earring",
        body="Ken. Samue +1",hands="Ken. Tekko +1",ring1="Defending Ring",right_ring="Fortified Ring",
        back=gear.tp_jse_back,waist="Flume Belt",legs="Ken. Hakama +1",feet="Ken. Sune-Ate +1"}
		
	-- sets.defense.MEVA = {ammo="Staunch Tathlum +1",
		-- head=empty,neck="Warder's Charm +1",ear1="Etiolation Earring",ear2="Sanare Earring",
		-- body="Respite Cloak",hands="Leyline Gloves",ring1="Vengeful Ring",Ring2="Purity Ring",
		-- back="Toro Cape",waist="Flax Sash",legs="Samnuha Tights",feet="Malignance Boots"}

	sets.Kiting = {feet="Herald's Gaiters"}

	-- Engaged sets

	-- Variations for TP weapon and (optional) offense/defense modes.  Code will fall back on previous
	-- sets if more refined versions aren't defined.
	-- If you create a set with both offense and defense modes, the offense mode should be first.
	-- EG: sets.engaged.Dagger.Accuracy.Evasion

	-- Normal melee sets
    sets.engaged = {ammo="Aurgelmir Orb",
        head="Adhemar Bonnet +1",neck="Moonlight Nodowa",ear1="Sherida Earring",ear2="Telos Earring",
        body="Ken. Samue +1",hands="Adhemar Wristbands +1",ring1="Niqmaddu Ring",ring2="Chirich Ring +1",
        back=gear.tp_jse_back,waist="Moonbow Belt +1",legs="Ken. Hakama +1",feet="Ken. Sune-Ate +1"}
    sets.engaged.SomeAcc = {ammo="Aurgelmir Orb",
        head="Adhemar Bonnet +1",neck="Moonlight Nodowa",ear1="Sherida Earring",ear2="Telos Earring",
        body="Ken. Samue +1",hands="Adhemar Wristbands +1",ring1="Chirich Ring +1",ring2="Chirich Ring +1",
        back=gear.tp_jse_back,waist="Moonbow Belt +1",legs="Ken. Hakama +1",feet="Ken. Sune-Ate +1"}
    sets.engaged.Acc = {ammo="Falcon Eye",
        head="Ken. Jinpachi +1",neck="Moonlight Nodowa",ear1="Sherida Earring",ear2="Telos Earring",
        body="Ken. Samue +1",hands="Ken. Tekko +1",ring1="Chirich Ring +1",ring2="Chirich Ring +1",
        back=gear.tp_jse_back,waist="Moonbow Belt +1",legs="Ken. Hakama +1",feet="Ken. Sune-Ate +1"}
	sets.engaged.FullAcc = {ammo="Falcon Eye",
        head="Ken. Jinpachi +1",neck="Moonlight Nodowa",ear1="Sherida Earring",ear2="Mache Earring +1",
        body="Ken. Samue +1",hands="Ken. Tekko +1",ring1="Chirich Ring +1",ring2="Chirich Ring +1",
        back=gear.tp_jse_back,waist="Moonbow Belt +1",legs="Ken. Hakama +1",feet="Ken. Sune-Ate +1"}
	sets.engaged.Fodder = {ammo="Aurgelmir Orb",
        head="Adhemar Bonnet +1",neck="Moonlight Nodowa",ear1="Sherida Earring",ear2="Telos Earring",
        body="Ken. Samue +1",hands="Adhemar Wristbands +1",ring1="Epona's Ring",ring2="Chirich Ring +1",
        back=gear.tp_jse_back,waist="Moonbow Belt +1",legs="Ken. Hakama +1",feet="Ken. Sune-Ate +1"}

	-- Defensive melee hybrid sets
    sets.engaged.PDT = {ammo="Staunch Tathlum +1",
        head="Ken. Jinpachi +1",neck="Loricate Torque +1",
        body="Ken. Samue +1",hands="Ken. Tekko +1",ring1="Defending Ring",right_ring="Epona's Ring",
        back=gear.tp_jse_back,waist="Flume Belt",legs="Ken. Hakama +1",feet="Ken. Sune-Ate +1"}
    sets.engaged.SomeAcc.PDT = {ammo="Staunch Tathlum +1",
        head="Ken. Jinpachi +1",neck="Loricate Torque +1",
        body="Ken. Samue +1",hands="Ken. Tekko +1",ring1="Defending Ring",right_ring="Epona's Ring",
        back=gear.tp_jse_back,waist="Moonbow Belt +1",legs="Ken. Hakama +1",feet="Ken. Sune-Ate +1"}
    sets.engaged.Acc.PDT = {ammo="Staunch Tathlum +1",
        head="Ken. Jinpachi +1",neck="Moonlight Nodowa",
        body="Ken. Samue +1",hands="Ken. Tekko",ring1="Defending Ring",right_ring="Epona's Ring",
        back=gear.tp_jse_back,waist="Moonbow Belt +1",legs="Ken. Hakama +1",feet="Ken. Sune-Ate +1"}
	sets.engaged.FullAcc.PDT = {ammo="Staunch Tathlum +1",
        head="Ken. Jinpachi +1",neck="Moonlight Nodowa",
        body="Ken. Samue +1",hands="Ken. Tekko +1",ring1="Defending Ring",right_ring="Epona's Ring",
        back=gear.tp_jse_back,waist="Moonbow Belt +1",legs="Ken. Hakama +1",feet="Ken. Sune-Ate +1"}
	sets.engaged.Fodder.PDT = {ammo="Staunch Tathlum +1",
        head="Adhemar Bonnet +1",neck="Loricate Torque +1",
        body="Ken. Samue +1",hands="Adhemar Wristbands +1",ring1="Defending Ring",right_ring="Epona's Ring",
        back=gear.tp_jse_back,waist="Flume Belt",legs="Ken. Hakama +1",feet="Ken. Sune-Ate +1"}

	-- Hundred Fists/Impetus melee set mods
	
	sets.engaged.HF = set_combine(sets.engaged, {})
	sets.engaged.SomeAcc.HF = set_combine(sets.engaged.SomeAcc, {})
	sets.engaged.Acc.HF = set_combine(sets.engaged.Acc, {})
	sets.engaged.FullAcc.HF = set_combine(sets.engaged.FullAcc, {})
	sets.engaged.Fodder.HF = set_combine(sets.engaged.Fodder, {})




	sets.buff.Doom = set_combine(sets.buff.Doom, {})
	sets.buff.Sleep = {head="Frenzy Sallet"}
	sets.buff.Impetus = {body="Bhikku Cyclas +1"}
	sets.buff.Footwork = {feet="Shukuyu Sune-Ate"}
	sets.buff.Boost = {} --waist="Ask Sash"
	
	sets.FootworkWS = {feet="Shukuyu Sune-Ate"}
	sets.DayIdle = {}
	sets.NightIdle = {}
    sets.Knockback = {}
	sets.TreasureHunter = set_combine(sets.TreasureHunter, {})
	sets.Skillchain = {legs="Ryuo Hakama"}
	
	-- Weapons sets
	sets.weapons.Godhands = {main="Godhands"}
	sets.weapons.Barehanded = {main=empty}
	sets.weapons.Staff = {main="Malignance Pole",sub="Bloodrain Strap"}
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
        set_macro_page(1, 1)
    elseif player.sub_job == 'DNC' then
        set_macro_page(4, 1)
    else
        set_macro_page(1, 1)
    end
end
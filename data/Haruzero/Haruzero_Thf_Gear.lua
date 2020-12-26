-- Setup vars that are user-dependent.  Can override this function in a sidecar file.
function user_job_setup()
	-- Options: Override default values
    state.OffenseMode:options('Normal','SomeAcc','Acc','FullAcc','Crit','Fodder')
    state.HybridMode:options('Normal','PDT','MDT')
    state.RangedMode:options('Normal', 'Acc')
    state.WeaponskillMode:options('Match','Normal','SomeAcc','Acc','FullAcc','Fodder','Proc')
	state.IdleMode:options('Normal', 'Sphere')
    state.PhysicalDefenseMode:options('PDT')
	state.MagicalDefenseMode:options('MDT')
	state.ResistDefenseMode:options('MEVA')
	state.Weapons:options('Evisceration','EviscerationTH','Aeneas','Savage','MagicWeapons')

    state.ExtraMeleeMode = M{['description']='Extra Melee Mode','None','Suppa','DWMax','Parry'}
	state.AmbushMode = M(false, 'Ambush Mode')

	gear.tp_jse_back = { name="Toutatis's Cape", augments={'DEX+20','Accuracy+20 Attack+20','"Store TP"+10','Phys. dmg. taken-10%',}}
	gear.wsd_jse_back = { name="Toutatis's Cape", augments={'DEX+20','Accuracy+20 Attack+20','DEX+10','Weapon skill damage +10%','Magic dmg. taken-10%'}}
	gear.fc_jse_back= {}

	gear.herculean_fc_head = { name="Herculean Helm", augments={'"Fast Cast"+6','Mag. Acc.+7','"Mag.Atk.Bns."+9',}}
	gear.herculean_fc_feet = {name="Herculean Boots", augments={'Mag. Acc.+9','"Fast Cast"+5','STR+9','"Mag.Atk.Bns."+6',}}
	gear.herculean_wsd_feet = {name="Herculean Boots", augments={'Weapon skill damage +3%','DEX+12','Accuracy+3',}}
	
	gear.herculean_nuke_head = { name="Herculean Helm", augments={'Weapon skill damage +2%','INT+12','Mag. Acc.+13',}}
	gear.herculean_nuke_legs = { name="Herculean Trousers", augments={'"Mag.Atk.Bns."+23','Weapon skill damage +4%','MND+4',}}
	gear.herculean_nuke_feet = { name="Herculean Boots", augments={'Weapon skill damage +2%','INT+11','"Mag.Atk.Bns."+3',}}

    -- Additional local binds
    send_command('bind ^` input /ja "Flee" <me>')
    send_command('bind !` input /ra <t>')
	send_command('bind @` gs c cycle SkillchainMode')
	send_command('bind @f10 gs c toggle AmbushMode')
	send_command('bind ^backspace input /item "Thief\'s Tools" <t>')
	send_command('bind ^q gs c weapons ProcWeapons;gs c set WeaponSkillMode proc;')
	send_command('bind !q gs c weapons SwordThrowing')
	send_command('bind !backspace input /ja "Hide" <me>')
	send_command('bind ^r gs c weapons Default;gs c set WeaponSkillMode match') --Requips weapons and gear.
	send_command('bind !r gs c cycle weapons;gs c update')
	send_command('bind ^\\\\ input /ja "Despoil" <t>')
	send_command('bind !\\\\ input /ja "Mug" <t>')

    select_default_macro_book()
end

-- Define sets and vars used by this job file.
function init_gear_sets()
    --------------------------------------
    -- Special sets (required by rules)
    --------------------------------------

	sets.TreasureHunter = {hands="Plunderer's Armlets +3",waist="Chaac Belt",feet="Skulk. Poulaines +1"}
    sets.ExtraRegen = {}
    sets.Kiting = {feet="Skd. Jambeaux +1"}

	sets.buff.Doom = set_combine(sets.buff.Doom, {})
	sets.buff.Sleep = {head="Frenzy Sallet"}
	
    sets.buff['Sneak Attack'] = {feet="Plun. Poulaines +3"}
    sets.buff['Trick Attack'] = {}

    -- Extra Melee sets.  Apply these on top of melee sets.
    sets.Knockback = {}
	sets.Suppa = {ear1="Suppanomimi", ear2="Sherida Earring"}
	sets.DWEarrings = {ear1="Dudgeon Earring",ear2="Heartseeker Earring"}
	sets.DWMax = {ear1="Dudgeon Earring",ear2="Heartseeker Earring",body="Adhemar Jacket +1",hands="Floral Gauntlets",waist="Reiki Yotai"}
	sets.Parry = {hands="Turms Mittens +1",ring1="Defending Ring"}
	sets.Ambush = {} --body="Plunderer's Vest +3"
	
	-- Weapons sets
	sets.weapons.Evisceration = {main="Tauret",sub="Shijo"}
	sets.weapons.EviscerationTH = {main="Tauret",sub="Sandung"}
	sets.weapons.Aeneas = {main="Aeneas",sub="Tauret"}
	sets.weapons.Savage = {main="Naegling",sub="Tauret"}
	sets.weapons.MagicWeapons = {main="Taming Sari",sub="Malevolence"}
	--sets.weapons.ProcWeapons = {main="Blurred Knife +1",sub="Atoyac"}
	--sets.weapons.Throwing = {main="Aeneas",sub="Shijo",range="Raider's Bmrng."}
	--sets.weapons.SwordThrowing = {main="Naegling",sub="Shijo",range="Raider's Bmrng"}
	--sets.weapons.Bow = {main="Aeneas",sub="Kustawi +1",range="Kaja Bow",ammo="Chapuli Arrow"}
	
    -- Actions we want to use to tag TH.
    sets.precast.Step = {ammo="C. Palug Stone",
        head="Malignance Chapeau",neck="Combatant's Torque",ear1="Mache Earring +1",ear2="Odr Earring",
        body="Malignance Tabard",hands="Malignance Gloves",ring1="Ramuh Ring +1",ring2="Ramuh Ring +1",
        back=gear.tp_jse_back,waist="Olseni Belt",legs="Malignance Tights",feet="Malignance Boots"}
		
    sets.precast.JA['Violent Flourish'] = {ammo="C. Palug Stone",
        head="Malignance Chapeau",neck="Combatant's Torque",ear1="Digni. Earring",ear2="Odr Earring",
        body="Malignance Tabard",hands="Malignance Gloves",ring1="Ramuh Ring +1",ring2="Ramuh Ring +1",
        back=gear.tp_jse_back,waist="Olseni Belt",legs="Malignance Tights",feet="Malignance Boots"}
		
	sets.precast.JA['Animated Flourish'] = sets.TreasureHunter
	sets.precast.JA.Provoke = sets.TreasureHunter

    --------------------------------------
    -- Precast sets
    --------------------------------------

    -- Precast sets to enhance JAs
    -- sets.precast.JA['Collaborator'] = {"Skulker's Bonnet"}
    -- sets.precast.JA['Accomplice'] = {"Skulker's Bonnet"}
    -- sets.precast.JA['Flee'] = {} --feet="Pillager's Poulaines +1"
    -- sets.precast.JA['Hide'] = {body="Pillager's Vest +1"}
    -- sets.precast.JA['Conspirator'] = {body="Skulker's Vest"} 
    -- sets.precast.JA['Steal'] = {hands="Pill. Armlets +1"}
	-- sets.precast.JA['Mug'] = {}
    -- sets.precast.JA['Despoil'] = {legs="Skulker's Culottes",feet="Skulk. Poulaines +1"}
    -- sets.precast.JA['Perfect Dodge'] = {hands="Plunderer's Armlets +3"}
    -- sets.precast.JA['Feint'] = {} -- {legs="Assassin's Culottes +2"}
	
    sets.precast.JA['Collaborator'] = {head="Raider's Bonnet +2"}
    sets.precast.JA['Accomplice'] = {head="Raider's Bonnet +2"}
    sets.precast.JA['Flee'] = {feet="Rogue's Poulaines"}
    sets.precast.JA['Hide'] = {body="Pillager's Vest +2"}
    sets.precast.JA['Conspirator'] = {body="Raider's Vest +2"}
    sets.precast.JA['Steal'] = {head="Pill. Bonnet +2",hands="Rogue's Armlets",legs="Pillager's Culottes +2",feet="Rogue's Poulaines"}
    sets.precast.JA['Despoil'] = {legs="Raider's Culottes +2",feet="Raider's Poulaines +2"}
    sets.precast.JA['Perfect Dodge'] = {hands="Plunderer's Armlets +3"}
    sets.precast.JA['Feint'] = {legs="Plun. Culottes +3"}

    sets.precast.JA['Sneak Attack'] = sets.buff['Sneak Attack']
    sets.precast.JA['Trick Attack'] = sets.buff['Trick Attack']

    -- Waltz set (chr and vit)
    sets.precast.Waltz = {ammo="Yamarang",
        head="Mummu Bonnet +2",neck="Unmoving Collar +1",ear1="Enchntr. Earring +1",ear2="Handler's Earring +1",
        body=gear.herculean_waltz_body,hands=gear.herculean_waltz_hands,ring1="Defending Ring",ring2="Valseur's Ring",
        back="Moonlight Cape",waist="Chaac Belt",legs="Dashing Subligar",feet=gear.herculean_waltz_feet}

	sets.Self_Waltz = {head="Mummu Bonnet +2",body="Passion Jacket",ring1="Asklepian Ring"}
		
    -- Don't need any special gear for Healing Waltz.
    sets.precast.Waltz['Healing Waltz'] = {}


    -- Fast cast sets for spells, Dread Jupon for body?
    sets.precast.FC = {ammo="Impatiens",
		head=gear.herculean_fc_head,neck="Baetyl Pendant",ear1="Enchntr. Earring +1",ear2="Loquac. Earring",
		body="Samnuha Coat",hands="Leyline Gloves",ring1="Lebeche Ring",ring2="Prolix Ring",
		back=gear.fc_jse_back,waist="Tempus Fugit",legs="Rawhide Trousers", feet=gear.herculean_fc_feet}

    sets.precast.FC.Utsusemi = set_combine(sets.precast.FC, {neck="Magoraga Beads",body="Passion Jacket"})


    -- Ranged snapshot gear
    sets.precast.RA = {range="Wingcutter",ammo="",head="Aurore Beret",hands="Iuitl Wristbands",legs="Nahtirah Trousers",feet="Wurrukatte Boots"}


    -- Weaponskill sets

    -- Default set for any weaponskill that isn't any more specifically defined
    sets.precast.WS = {ammo="Yetshila +1",
        head="Pill. Bonnet +2",neck="Fotia Gorget",ear1="Moonshade Earring",ear2="Sherida Earring",
        body="Plunderer's Vest +3",hands="Meg. Gloves +1",ring1="Ilabrat Ring",ring2="Ramuh Ring",
        back=gear.wsd_jse_back,waist="Fotia Belt",legs="Plun. Culottes +3",feet="Plun. Poulaines +3"}
    sets.precast.WS.SomeAcc = set_combine(sets.precast.WS, {})
    sets.precast.WS.Acc = set_combine(sets.precast.WS, {ear1="Telos Earring",ear2="Odr Earring"})
	sets.precast.WS.FullAcc = set_combine(sets.precast.WS, {ear1="Telos Earring",ear2="Odr Earring"})

    -- Specific weaponskill sets.  Uses the base set if an appropriate WSMod version isn't found.
    sets.precast.WS["Rudra's Storm"] = set_combine(sets.precast.WS, {ammo="Seething Bomblet +1",
        head="Plunderer's Bonnet +3",neck="Asn. Gorget +1",ear1="Moonshade Earring",ear2="Sherida Earring",
        body="Plunderer's Vest +3",hands="Meg. Gloves +1",ring1="Ilabrat Ring",ring2="Ramuh Ring",
        back=gear.wsd_jse_back,waist="Grunfeld Rope",legs="Plun. Culottes +3",feet="Plun. Poulaines +3"})
    sets.precast.WS["Rudra's Storm"].SomeAcc = set_combine(sets.precast.WS.SomeAcc, {})
    sets.precast.WS["Rudra's Storm"].Acc = set_combine(sets.precast.WS.Acc, {})
	sets.precast.WS["Rudra's Storm"].FullAcc = set_combine(sets.precast.WS.FullAcc, {})
    sets.precast.WS["Rudra's Storm"].Fodder = set_combine(sets.precast.WS["Rudra's Storm"], {})
    sets.precast.WS["Rudra's Storm"].SA = set_combine(sets.precast.WS["Rudra's Storm"].Fodder, {})
    sets.precast.WS["Rudra's Storm"].TA = set_combine(sets.precast.WS["Rudra's Storm"].Fodder, {})
    sets.precast.WS["Rudra's Storm"].SATA = set_combine(sets.precast.WS["Rudra's Storm"].Fodder, {})

    sets.precast.WS["Mandalic Stab"] = set_combine(sets.precast.WS, {ammo="Seething Bomblet +1",
        head="Plunderer's Bonnet +3",neck="Asn. Gorget +1",ear1="Moonshade Earring",ear2="Sherida Earring",
        body="Plunderer's Vest +3",hands="Meg. Gloves +1",ring1="Ilabrat Ring",ring2="Ramuh Ring",
        back=gear.wsd_jse_back,waist="Grunfeld Rope",legs="Plun. Culottes +3",feet="Plun. Poulaines +3"})
    sets.precast.WS["Mandalic Stab"].SomeAcc = set_combine(sets.precast.WS.SomeAcc, {})
    sets.precast.WS["Mandalic Stab"].Acc = set_combine(sets.precast.WS.Acc, {})
	sets.precast.WS["Mandalic Stab"].FullAcc = set_combine(sets.precast.WS.FullAcc, {})
    sets.precast.WS["Mandalic Stab"].Fodder = set_combine(sets.precast.WS["Mandalic Stab"], {})
    sets.precast.WS["Mandalic Stab"].SA = set_combine(sets.precast.WS["Mandalic Stab"].Fodder, {})
    sets.precast.WS["Mandalic Stab"].TA = set_combine(sets.precast.WS["Mandalic Stab"].Fodder, {})
    sets.precast.WS["Mandalic Stab"].SATA = set_combine(sets.precast.WS["Mandalic Stab"].Fodder, {})

    sets.precast.WS["Shark Bite"] = set_combine(sets.precast.WS, {})
    sets.precast.WS["Shark Bite"].SomeAcc = set_combine(sets.precast.WS.SomeAcc, {})
    sets.precast.WS["Shark Bite"].Acc = set_combine(sets.precast.WS.Acc, {})
	sets.precast.WS["Shark Bite"].FullAcc = set_combine(sets.precast.WS.FullAcc, {})
    sets.precast.WS["Shark Bite"].Fodder = set_combine(sets.precast.WS["Shark Bite"], {})
    sets.precast.WS["Shark Bite"].SA = set_combine(sets.precast.WS["Shark Bite"].Fodder, {})
    sets.precast.WS["Shark Bite"].TA = set_combine(sets.precast.WS["Shark Bite"].Fodder, {})
    sets.precast.WS["Shark Bite"].SATA = set_combine(sets.precast.WS["Shark Bite"].Fodder, {})
	
    sets.precast.WS['Evisceration'] = set_combine(sets.precast.WS, {ammo="Yetshila +1",
		head="Adhemar Bonnet +1",neck="Fotia Gorget",ear1="Moonshade Earring",ear2="Odr Earring",
		body="Plunderer's Vest +3",hands="Adhemar Wristbands +1",ring1="Ilabrat Ring",ring2="Ramuh Ring",
		back=gear.wsd_jse_back,waist="Fotia Belt",legs="Pillager's Culottes +2",feet="Adhemar Gamashes +1"})
    sets.precast.WS['Evisceration'].SomeAcc = set_combine(sets.precast.WS.SomeAcc, {})
    sets.precast.WS['Evisceration'].Acc = set_combine(sets.precast.WS.Acc, {})
	sets.precast.WS['Evisceration'].FullAcc = set_combine(sets.precast.WS.FullAcc, {})
	sets.precast.WS['Evisceration'].Fodder = set_combine(sets.precast.WS['Evisceration'], {})
	
	sets.precast.WS['Exenterator'] = set_combine(sets.precast.WS, {ammo="Seething Bomblet +1",
        head="Plunderer's Bonnet +3",neck="Fotia Gorget",ear1="Moonshade Earring",ear2="Sherida Earring",
        body="Plunderer's Vest +3",hands="Meg. Gloves +1",ring1="Ilabrat Ring",ring2="Ramuh Ring",
        back=gear.wsd_jse_back,waist="Fotia Belt",legs="Meg. Chausses +2",feet="Plun. Poulaines +3"})
    sets.precast.WS['Exenterator'].SomeAcc = set_combine(sets.precast.WS.SomeAcc, {})
    sets.precast.WS['Exenterator'].Acc = set_combine(sets.precast.WS.Acc, {})
	sets.precast.WS['Exenterator'].FullAcc = set_combine(sets.precast.WS.FullAcc, {})
	sets.precast.WS['Exenterator'].Fodder = set_combine(sets.precast.WS['Evisceration'], {})
	
    sets.precast.WS["Savage Blade"] = set_combine(sets.precast.WS, {ammo="Seething Bomblet +1",
        head="Pill. Bonnet +3",neck="Caro Necklace",ear1="Moonshade Earring",ear2="Thrud Earring",
        body="Plunderer's Vest +3",hands="Meg. Gloves +2",ring1="Epona's Ring",ring2="Ifrit Ring",
        back=gear.wsd_jse_back,waist="Grunfeld Rope",legs="Plun. Culottes +3",feet="Plun. Poulaines +3"})
    sets.precast.WS["Savage Blade"].SomeAcc = set_combine(sets.precast.WS.SomeAcc, {})
    sets.precast.WS["Savage Blade"].Acc = set_combine(sets.precast.WS.Acc, {})
	sets.precast.WS["Savage Blade"].FullAcc = set_combine(sets.precast.WS.FullAcc, {})
    sets.precast.WS["Savage Blade"].Fodder = set_combine(sets.precast.WS["Savage Blade"], {})
    sets.precast.WS["Savage Blade"].SA = set_combine(sets.precast.WS["Savage Blade"].Fodder, {})
    sets.precast.WS["Savage Blade"].TA = set_combine(sets.precast.WS["Savage Blade"].Fodder, {})
    sets.precast.WS["Savage Blade"].SATA = set_combine(sets.precast.WS["Savage Blade"].Fodder, {})

    sets.precast.WS.Proc = {ammo="Yamarang",
        head="Malignance Chapeau",neck="Voltsurge Torque",ear1="Digni. Earring",ear2="Heartseeker Earring",
        body="Malignance Tabard",hands="Malignance Gloves",ring1="Varar Ring +1",ring2="Varar Ring +1",
        back="Ground. Mantle +1",waist="Olseni Belt",legs="Malignance Tights",feet="Malignance Boots"}

    sets.precast.WS['Last Stand'] = {
        head="Pill. Bonnet +3",neck="Fotia Gorget",ear1="Enervating Earring",ear2="Telos Earring",
        body="Malignance Tabard",hands="Malignance Gloves",ring1="Apate Ring",ring2="Regal Ring",
        back=gear.wsd_jse_back,waist="Fotia Belt",legs="Malignance Tights",feet="Malignance Boots"}
		
    sets.precast.WS['Empyreal Arrow'] = {
        head="Pill. Bonnet +3",neck="Fotia Gorget",ear1="Enervating Earring",ear2="Telos Earring",
        body="Malignance Tabard",hands="Malignance Gloves",ring1="Apate Ring",ring2="Regal Ring",
        back=gear.wsd_jse_back,waist="Fotia Belt",legs="Malignance Tights",feet="Malignance Boots"}
		
    sets.precast.WS['Aeolian Edge'] = set_combine(sets.precast.WS,{ammo="Seeth. Bomblet +1",
        head=gear.herculean_nuke_head,neck="Baetyl Pendant",ear1="Moonshade Earring",ear2="Friomisi Earring",
        body="Samnuha Coat",hands="Leyline Gloves",ring1="Shiva Ring",ring2="Shiva Ring",
        back=gear.wsd_jse_back,waist="Eschan Stone",legs=gear.herculean_nuke_legs,feet=gear.herculean_nuke_feet})

    sets.precast.WS['Aeolian Edge'].TH = set_combine(sets.precast.WS['Aeolian Edge'], sets.TreasureHunter)

	-- Swap to these on Moonshade using WS if at 3000 TP
	sets.MaxTP = {ear1="Thrud Earring",ear2="Sherida Earring"}
	sets.AccMaxTP = {ear1="Mache Earring +1",ear2="Sherida Earring"}

    --------------------------------------
    -- Midcast sets
    --------------------------------------

    sets.midcast.FastRecast = {ammo="Staunch Tathlum +1",
        head=gear.herculean_fc_head,neck="Loricate Torque +1",ear1="Odnowa Earring +1",ear2="Ethereal Earring",
        body="Dread Jupon",hands="Leyline Gloves",ring1="Defending Ring",ring2="Moonlight Ring",
        back="Moonbeam Cape",waist="Tempus Fugit",legs="Rawhide Trousers",feet=gear.herculean_fc_feet}

    -- Specific spells
	sets.midcast.Utsusemi = set_combine(sets.midcast.FastRecast, {back="Mujin Mantle"})

	sets.midcast.Dia = set_combine(sets.midcast.FastRecast, sets.TreasureHunter)
	sets.midcast.Diaga = set_combine(sets.midcast.FastRecast, sets.TreasureHunter)
	sets.midcast['Dia II'] = set_combine(sets.midcast.FastRecast, sets.TreasureHunter)
	sets.midcast.Bio = set_combine(sets.midcast.FastRecast, sets.TreasureHunter)
	sets.midcast['Bio II'] = set_combine(sets.midcast.FastRecast, sets.TreasureHunter)

    -- Ranged gear

    sets.midcast.RA = {
        head="Malignance Chapeau",neck="Iskur Gorget",ear1="Enervating Earring",ear2="Telos Earring",
        body="Malignance Tabard",hands="Malignance Gloves",ring1="Apate Ring",ring2="Regal Ring",
        back=gear.tp_jse_back,waist="Chaac Belt",legs="Malignance Tights",feet="Malignance Boots"}

    sets.midcast.RA.Acc = {
        head="Malignance Chapeau",neck="Iskur Gorget",ear1="Enervating Earring",ear2="Telos Earring",
        body="Malignance Tabard",hands="Malignance Gloves",ring1="Apate Ring",ring2="Regal Ring",
        back=gear.tp_jse_back,waist="Chaac Belt",legs="Malignance Tights",feet="Malignance Boots"}

    --------------------------------------
    -- Idle/resting/defense sets
    --------------------------------------

    -- Resting sets
    sets.resting = {}

    -- Idle sets (default idle set not needed since the other three are defined, but leaving for testing purposes)

    sets.idle = {ammo="Staunch Tathlum +1",
        head="Mummu Bonnet +1",neck="Loricate Torque +1",ear1="Odnowa Earring +1",ear2="Ethereal Earring",
        body="Mummu Jacket +1",hands="Mummu Wrists +2",ring1="Defending Ring",ring2="Shneddick Ring",
        back=gear.tp_jse_back,waist="Flume Belt",legs="Malignance Tights",feet="Mummu Gamashes +1"}
		
    sets.idle.Sphere = set_combine(sets.idle, {body="Mekosu. Harness"})

    sets.idle.Town = {range=empty,ammo="Aurgelmir Orb",
        head="Adhemar Bonnet +1",neck="Asn. Gorget +1",ear1="Sherida Earring",ear2="Telos Earring",
        body="Pillager's Vest +2",hands="Adhemar Wristbands +1",ring1="Ilabrat Ring",ring2="Shneddick Ring",
        back=gear.tp_jse_back,waist="Reiki Yotai",legs="Samnuha Tights",feet="Plun. Poulaines +3"}

    sets.idle.Weak = set_combine(sets.idle, {})

	sets.DayIdle = {}
	sets.NightIdle = {}
	sets.ExtraRegen = {hands="Turms Mittens +1"}

    -- Defense sets

    sets.defense.PDT = {ammo="Staunch Tathlum +1",
        head="Mummu Bonnet +1",neck="Loricate Torque +1",ear1="Genmei Earring",ear2="Ethereal Earring",
        body="Mummu Jacket +1",hands="Mummu Wrists +2",ring1="Defending Ring",ring2="Gelatinous Ring +1",
        back=gear.tp_jse_back,waist="Flume Belt",legs="Malignance Tights",feet="Mummu Gamashes +1"}

    sets.defense.MDT = {ammo="Staunch Tathlum +1",
        head="Mummu Bonnet +1",neck="Loricate Torque +1",ear1="Genmei Earring",ear2="Ethereal Earring",
        body="Mummu Jacket +1",hands="Mummu Wrists +2",ring1="Defending Ring",ring2="Moonlight Ring",
        back="Engulfer Cape +1",waist="Flume Belt",legs="Malignance Tights",feet="Mummu Gamashes +1"}
		
	sets.defense.MEVA = {ammo="Staunch Tathlum +1",
		head=gear.herculean_fc_head,neck="Warder's Charm +1",ear1="Etiolation Earring",ear2="Sanare Earring",
		body="Adhemar Jacket +1",hands="Malignance Gloves",ring1="Vengeful Ring",ring2="Purity Ring",
		back="Mujin Mantle",waist="Engraved Belt",legs="Malignance Tights",feet="Malignance Boots"}


    --------------------------------------
    -- Melee sets  
    --------------------------------------

    -- Normal melee group
    sets.engaged = {ammo="Aurgelmir Orb",
        head="Adhemar Bonnet +1",neck="Asn. Gorget +1",ear1="Sherida Earring",ear2="Telos Earring",
        body="Pillager's Vest +2",hands="Adhemar Wristbands +1",ring1="Ilabrat Ring",ring2="Epona's Ring",
        back=gear.tp_jse_back,waist="Reiki Yotai",legs="Samnuha Tights",feet="Plun. Poulaines +3"}
		
    sets.engaged.SomeAcc = {ammo="Yamarang",
        head="Adhemar Bonnet +1",neck="Asn. Gorget +1",ear1="Sherida Earring",ear2="Telos Earring",
        body="Pillager's Vest +2",hands="Adhemar Wristbands +1",ring1="Ilabrat Ring",ring2="Epona's Ring",
        back=gear.tp_jse_back,waist="Reiki Yotai",legs="Pillager's Culottes +2",feet="Plun. Poulaines +3"}
    
	sets.engaged.Acc = {ammo="Yamarang",
        head="Adhemar Bonnet +1",neck="Asn. Gorget +1",ear1="Sherida Earring",ear2="Telos Earring",
        body="Pillager's Vest +2",hands="Adhemar Wristbands +1",ring1="Ilabrat Ring",ring2="Chirich Ring +1",
        back=gear.tp_jse_back,waist="Reiki Yotai",legs="Pillager's Culottes +2",feet="Plun. Poulaines +3"}
		
	sets.engaged.FullAcc = {ammo="Yamarang",
        head="Plunderer's Bonnet +3",neck="Asn. Gorget +1",ear1="Sherida Earring",ear2="Telos Earring",
        body="Pillager's Vest +2",hands="Adhemar Wristbands +1",ring1="Ilabrat Ring",ring2="Chirich Ring +1",
        back=gear.tp_jse_back,waist="Reiki Yotai",legs="Pillager's Culottes +2",feet="Plun. Poulaines +3"}
		
    sets.engaged.Crit = {ammo="Yetshila +1",
        head="Mummu Bonnet +1",neck="Asn. Gorget +1",ear1="Telos Earring",ear2="Odr Earring",
        body="Mummu Jacket +1",hands="Mummu Wrists +2",ring1="Ramuh Ring",ring2="Mummu Ring",
        back=gear.tp_jse_back,waist="Windbuffet Belt +1",legs="Mummu Kecks +1",feet="Mummu Gamashes +1"}

    sets.engaged.Fodder = {ammo="Aurgelmir Orb",
        head="Adhemar Bonnet +1",neck="Asn. Gorget +1",ear1="Sherida Earring",ear2="Telos Earring",
        body="Pillager's Vest +2",hands="Adhemar Wristbands +1",ring1="Ilabrat Ring",ring2="Epona's Ring",
        back=gear.tp_jse_back,waist="Reiki Yotai",legs="Samnuha Tights",feet="Plun. Poulaines +3"}

    sets.engaged.PDT = {ammo="Aurgelmir Orb",
        head="Adhemar Bonnet +1",neck="Asn. Gorget +1",ear1="Sherida Earring",ear2="Telos Earring",
        body="Pillager's Vest +2",hands="Adhemar Wristbands +1",ring1="Moonlight Ring",ring2="Moonlight Ring",
        back=gear.tp_jse_back,waist="Reiki Yotai",legs="Malignance Tights",feet="Plun. Poulaines +3"}
		
	sets.engaged.MDT = {ammo="Aurgelmir Orb",
	head="Adhemar Bonnet +1",neck="Asn. Gorget +1",ear1="Sherida Earring",ear2="Telos Earring",
	body="Pillager's Vest +2",hands="Adhemar Wristbands +1",ring1="Moonlight Ring",ring2="Moonlight Ring",
	back=gear.wsd_jse_back,waist="Reiki Yotai",legs="Malignance Tights",feet="Plun. Poulaines +3"}

end

-- Select default macro book on initial load or subjob change.
function select_default_macro_book()
    -- Default macro set/book
    if player.sub_job == 'DNC' then
        set_macro_page(1, 4)
    elseif player.sub_job == 'WAR' then
        set_macro_page(2, 4)
    elseif player.sub_job == 'NIN' then
        set_macro_page(3, 4)
    else
        set_macro_page(1, 4)
    end
end

--Job Specific Trust Override
function check_trust()
	if not moving then
		if state.AutoTrustMode.value and not data.areas.cities:contains(world.area) and (buffactive['Elvorseal'] or buffactive['Reive Mark'] or not player.in_combat) then
			local party = windower.ffxi.get_party()
			if party.p5 == nil then
				local spell_recasts = windower.ffxi.get_spell_recasts()

				if spell_recasts[993] < spell_latency and not have_trust("ArkEV") then
					windower.chat.input('/ma "AAEV" <me>')
					tickdelay = os.clock() + 3
					return true
				elseif spell_recasts[955] < spell_latency and not have_trust("Apururu") then
					windower.chat.input('/ma "Apururu (UC)" <me>')
					tickdelay = os.clock() + 3
					return true
				elseif spell_recasts[952] < spell_latency and not have_trust("Koru-Moru") then
					windower.chat.input('/ma "Koru-Moru" <me>')
					tickdelay = os.clock() + 3
					return true
				elseif spell_recasts[967] < spell_latency and not have_trust("Qultada") then
					windower.chat.input('/ma "Qultada" <me>')
					tickdelay = os.clock() + 3
					return true
				elseif spell_recasts[914] < spell_latency and not have_trust("Ulmia") then
					windower.chat.input('/ma "Ulmia" <me>')
					tickdelay = os.clock() + 3
					return true
				else
					return false
				end
			end
		end
	end
	return false
end
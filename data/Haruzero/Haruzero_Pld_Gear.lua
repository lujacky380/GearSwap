function user_job_setup()

    -- Options: Override default values	
	state.OffenseMode:options('Normal','Acc')
    state.HybridMode:options('Tank','DDTank','Normal')
    state.WeaponskillMode:options('Match','Normal', 'Acc')
    state.CastingMode:options('Normal','SIRD')
	state.Passive:options('None','AbsorbMP')
    state.PhysicalDefenseMode:options('PDT')
    state.MagicalDefenseMode:options('MDT')
	state.ResistDefenseMode:options('MEVA')
	state.IdleMode:options('Normal','Tank','KiteTank','PDT','MDT','Refresh','Reraise')
	state.Weapons:options('None','DeaconAegis','SequenceAegis','SequenceBlurred')
	
    state.ExtraDefenseMode = M{['description']='Extra Defense Mode','None','MP','Twilight'}
	
	gear.fastcast_jse_back = {name="Rudianos's Mantle",augments={'INT+20','Eva.+20 /Mag. Eva.+20','Mag. Evasion+10','"Fast Cast"+10',}}
	gear.enmity_jse_back = {name="Rudianos's Mantle",augments={'HP+60','Eva.+20 /Mag. Eva.+20','HP+20','Enmity+10',}}
	gear.SIRD_jse_back = {}
	gear.odyssean_fc_legs = {name="Odyssean Cuisses", augments={'Accuracy+12','"Fast Cast"+5','MND+10','Attack+11',}}
	gear.odyssean_fc_feet = {name="Odyssean Greaves", augments={'Accuracy+14','"Fast Cast"+5','VIT+5','Attack+1',}}
	gear.enmity_jse_back = {name=""}
	gear.fastcast_jse_back = {name=""}
	gear.valorous_wsd_body = {name = ""}
	gear.odyssean_wsd_hands = {name = ""}
	

	-- ! = alt, ^ = ctrl, @ = windows key
	-- Additional local binds
	send_command('bind !` gs c SubJobEnmity')
	send_command('bind ^backspace input /ja "Shield Bash" <t>')
	send_command('bind @backspace input /ja "Cover" <stpt>')
	send_command('bind !backspace input /ja "Sentinel" <me>')
	send_command('bind @= input /ja "Chivalry" <me>')
	send_command('bind != input /ja "Palisade" <me>')
	send_command('bind ^delete input /ja "Provoke" <stnpc>')
	send_command('bind !delete input /ma "Cure IV" <stal>')
	send_command('bind @delete input /ma "Flash" <stnpc>')
    send_command('bind !f11 gs c cycle ExtraDefenseMode')
	send_command('bind @` gs c cycle RuneElement')
	send_command('bind ^pause gs c toggle AutoRuneMode')
	send_command('bind @f8 gs c toggle AutoTankMode')
	send_command('bind @f10 gs c toggle TankAutoDefense')
	send_command('bind ^@!` gs c cycle SkillchainMode')
	
    select_default_macro_book()
    update_defense_mode()
end

function init_gear_sets()
	
	--------------------------------------
	-- Precast sets
	--------------------------------------
	
    sets.Enmity = {ammo="Paeapua",
        head="Souv. Schaller +1",neck="Moonbeam Necklace",ear1="Friomisi Earring",ear2="Odnowa Earring",
        body="Souv. Cuirass +1",hands="Souv. Handsch. +1",ring1="Apeile Ring +1",ring2="Provocare Ring",
        back=gear.enmity_jse_back,waist="Creed Baudrier",legs="Souv. Diechlings +1",feet="Souveran Schuhs +1"}
		
    sets.Enmity.SIRD = {ammo="Staunch Tathlum +1",
		head="Souv. Schaller +1",neck="Moonbeam Necklace",ear1="Friomisi Earring",ear2="Knightly Earring",
		body="Souv. Cuirass +1",hands="Souv. Handsch. +1",ring1="Defending Ring",ring2="Moonlight Ring",
		back=gear.enmity_jse_back,waist="Creed Baudrier",legs="Founder's Hose",feet=gear.odyssean_fc_feet}
		
    sets.Enmity.DT = {ammo="Staunch Tathlum +1",
        head="Souv. Schaller +1",neck="Moonbeam Necklace",ear1="Odnowa Earring +1",ear2="Odnowa Earring",
        body="Souv. Cuirass +1",hands="Souv. Handsch. +1",ring1="Defending Ring",ring2="Moonlight Ring",
        back=gear.enmity_jse_back,waist="Creed Baudrier",legs="Souv. Diechlings +1",feet="Souveran Schuhs +1"}
		
    -- Precast sets to enhance JAs
    sets.precast.JA['Invincible'] = set_combine(sets.Enmity,{legs="Cab. Breeches +1"})
    sets.precast.JA['Holy Circle'] = set_combine(sets.Enmity,{feet="Rev. Leggings +3"})
    sets.precast.JA['Sentinel'] = set_combine(sets.Enmity,{feet="Cab. Leggings +1"})
    sets.precast.JA['Rampart'] = set_combine(sets.Enmity,{}) --head="Valor Coronet" (Also Vit?)
    sets.precast.JA['Fealty'] = set_combine(sets.Enmity,{body="Cab. Surcoat +1"})
    sets.precast.JA['Divine Emblem'] = set_combine(sets.Enmity,{feet="Chev. Sabatons +1"})
    sets.precast.JA['Cover'] = set_combine(sets.Enmity, {body="Cab. Surcoat +1"}) --head="Rev. Coronet +1",
	
    sets.precast.JA['Invincible'].DT = set_combine(sets.Enmity.DT,{legs="Cab. Breeches +1"})
    sets.precast.JA['Holy Circle'].DT = set_combine(sets.Enmity.DT,{feet="Rev. Leggings +3"})
    sets.precast.JA['Sentinel'].DT = set_combine(sets.Enmity.DT,{feet="Cab. Leggings +1"})
    sets.precast.JA['Rampart'].DT = set_combine(sets.Enmity.DT,{}) --head="Valor Coronet" (Also Vit?)
    sets.precast.JA['Fealty'].DT = set_combine(sets.Enmity.DT,{body="Cab. Surcoat +1"})
    sets.precast.JA['Divine Emblem'].DT = set_combine(sets.Enmity.DT,{feet="Chev. Sabatons +1"})
    sets.precast.JA['Cover'].DT = set_combine(sets.Enmity.DT, {body="Cab. Surcoat +1"}) --head="Rev. Coronet +1",
	
    -- add mnd for Chivalry
    sets.precast.JA['Chivalry'] = {
		head="Sulevia's Mask +2",neck="Phalaina Locket",ear1="Nourish. Earring",ear2="Nourish. Earring +1",
		body="Rev. Surcoat +3",hands="Cab. Gauntlets +1",ring1="Stikini Ring +1",ring2="Rufescent Ring",
		back=gear.enmity_jse_back,waist="Luminary Sash",legs="Carmine Cuisses +1",feet="Carmine Greaves +1"}

	sets.precast.JA['Shield Bash'] = set_combine(sets.Enmity, {hands="Cab. Gauntlets +1"})		
    sets.precast.JA['Provoke'] = set_combine(sets.Enmity, {})
	sets.precast.JA['Warcry'] = set_combine(sets.Enmity, {})
	sets.precast.JA['Palisade'] = set_combine(sets.Enmity, {})
	sets.precast.JA['Intervene'] = set_combine(sets.Enmity, {})
	sets.precast.JA['Defender'] = set_combine(sets.Enmity, {})
	sets.precast.JA['Berserk'] = set_combine(sets.Enmity, {})
	sets.precast.JA['Aggressor'] = set_combine(sets.Enmity, {})
	
	sets.precast.JA['Shield Bash'].DT = set_combine(sets.Enmity.DT, {hands="Cab. Gauntlets +1"})		
    sets.precast.JA['Provoke'].DT = set_combine(sets.Enmity.DT, {})
	sets.precast.JA['Warcry'].DT = set_combine(sets.Enmity.DT, {})
	sets.precast.JA['Palisade'].DT = set_combine(sets.Enmity.DT, {})
	sets.precast.JA['Intervene'].DT = set_combine(sets.Enmity.DT, {})
	sets.precast.JA['Defender'].DT = set_combine(sets.Enmity.DT, {})
	sets.precast.JA['Berserk'].DT = set_combine(sets.Enmity.DT, {})
	sets.precast.JA['Aggressor'].DT = set_combine(sets.Enmity.DT, {})

    -- Waltz set (chr and vit)
    sets.precast.Waltz = {
		head="Carmine Mask",
		body="Rev. Surcoat +3",ring1="Asklepian Ring",ring2="Valseur's Ring",
		waist="Chaac Belt",legs="Sulev. Cuisses +2"}
        
    -- Don't need any special gear for Healing Waltz.
    sets.precast.Waltz['Healing Waltz'] = {}
    
    sets.precast.Step = {ammo="Aurgelmir Orb",
        head="Founder's Corona",neck="Combatant's Torque",ear1="Mache Earring +1",ear2="Telos Earring",
        body="Tartarus Platemail",hands="Leyline Gloves",ring1="Ramuh Ring +1",ring2="Patricius Ring",
        back="Ground. Mantle +1",waist="Olseni Belt",legs="Carmine Cuisses +1",feet="Founder's Greaves"}
		
	sets.precast.JA['Violent Flourish'] = {ammo="Aurgelmir Orb +1",
        head="Founder's Corona",neck="Erra Pendant",ear1="Gwati Earring",ear2="Digni. Earring",
        body="Found. Breastplate",hands="Leyline Gloves",ring1="Defending Ring",ring2="Stikini Ring +1",
        back="Ground. Mantle +1",waist="Olseni Belt",legs="Carmine Cuisses +1",feet="Founder's Greaves"}
		
	sets.precast.JA['Animated Flourish'] = set_combine(sets.Enmity, {})

    -- Fast cast sets for spells
    
    sets.precast.FC = {ammo="Impatiens",
		head="Carmine Mask",neck="Baetyl Pendant",ear1="Enchntr. Earring +1",ear2="Loquac. Earring",
		body="Rev. Surcoat +3",hands="Leyline Gloves",ring1="Prolix Ring",ring2="Kishar Ring",
		back=gear.fastcast_jse_back,waist="Creed Baudrier",legs=gear.odyssean_fc_legs,feet=gear.odyssean_fc_feet}
		
    sets.precast.FC.DT = {ammo="Impatiens",
        head="Souv. Schaller +1",neck="Baetyl Pendant",ear1="Enchntr. Earring +1",ear2="Loquac. Earring",
        body="Rev. Surcoat +3",hands="Souv. Handsch. +1",ring1="Prolix Ring",ring2="Kishar Ring",
        back="Moonbeam Cape",waist="Creed Baudrier",legs="Souv. Diechlings +1",feet="Souveran Schuhs +1"}
		
    sets.precast.FC['Enhancing Magic'] = set_combine(sets.precast.FC, {waist="Siegel Sash"})
	
	sets.precast.FC.Cure = set_combine(sets.precast.FC, {neck="Diemer Gorget",ear1="Nourish. Earring",ear2="Nourish. Earring +1",body="Jumalik Mail"})
  
    -- Weaponskill sets
    -- Default set for any weaponskill that isn't any more specifically defined
    sets.precast.WS = {ammo="Paeapua",
		head="Souv. Schaller +1",neck="Fotia Gorget",ear1="Odnowa Earring +1",ear2="Odnowa Earring",
		body="Souv. Cuirass +1",hands="Souv. Handsch. +1",ring1="Petrov Ring",ring2="Ifrit Ring",
		back="Moonbeam Cape",waist="Fotia Belt",legs="Souv. Diechlings +1",feet="Souveran Schuhs +1"}
		
    sets.precast.WS.DT = {ammo="Staunch Tathlum +1",
        head="Souv. Schaller +1",neck="Loricate Torque +1",ear1="Odnowa Earring +1",ear2="Odnowa Earring",
        body="Rev. Surcoat +3",hands="Souv. Handsch. +1",ring1="Defending Ring",ring2="Moonlight Ring",
        back="Moonbeam Cape",waist="Creed Baudrier",legs="Souv. Diechlings +1",feet="Souveran Schuhs +1"}

    sets.precast.WS.Acc = {}

    -- Specific weaponskill sets.  Uses the base set if an appropriate WSMod version isn't found.
    sets.precast.WS['Requiescat'] = set_combine(sets.precast.WS, {neck="Fotia Gorget",ear1="Brutal Earring",ear2="Moonshade Earring"})
    sets.precast.WS['Requiescat'].Acc = set_combine(sets.precast.WS.Acc, {neck="Fotia Gorget",ear1="Mache Earring +1",ear2="Moonshade Earring"})

	sets.precast.WS['Chant du Cygne'] = set_combine(sets.precast.WS, {neck="Fotia Gorget",ear1="Brutal Earring",ear2="Moonshade Earring"})
    sets.precast.WS['Chant du Cygne'].Acc = set_combine(sets.precast.WS.Acc, {neck="Fotia Gorget",ear1="Mache Earring +1",ear2="Moonshade Earring"})

	sets.precast.WS['Savage Blade'] = set_combine(sets.precast.WS, {neck="Fotia Gorget",ear1="Ishvara Earring",ear2="Moonshade Earring"})
    sets.precast.WS['Savage Blade'].Acc = set_combine(sets.precast.WS.Acc, {ear1="Mache Earring +1",ear2="Telos Earring"})
	
	sets.precast.WS['Flat Blade'] = {}

	sets.precast.WS['Flat Blade'].Acc = {}

    sets.precast.WS['Sanguine Blade'] = {}

	sets.precast.WS['Sanguine Blade'].Acc = sets.precast.WS['Sanguine Blade']

    sets.precast.WS['Atonement'] = {}

    sets.precast.WS['Atonement'].Acc = sets.precast.WS['Atonement']
    sets.precast.WS['Spirits Within'] = sets.precast.WS['Atonement']
    sets.precast.WS['Spirits Within'].Acc = sets.precast.WS['Atonement']

	-- Swap to these on Moonshade using WS if at 3000 TP
	sets.MaxTP = {ear1="Cessance Earring",ear2="Brutal Earring",}
	sets.AccMaxTP = {ear1="Mache Earring +1",ear2="Telos Earring"}


	--------------------------------------
	-- Midcast sets
	--------------------------------------

    sets.midcast.FastRecast = {ammo="Staunch Tathlum +1",
        head="Souv. Schaller +1",neck="Moonbeam Necklace",ear1="Odnowa Earring +1",ear2="Knightly Earring",
        body="Rev. Surcoat +3",hands="Souv. Handsch. +1",ring1="Defending Ring",ring2="Moonlight Ring",
        back="Moonbeam Cape",waist="Tempus Fugit",legs="Founder's Hose",feet=gear.odyssean_fc_feet}
		
	sets.midcast.FastRecast.DT = {ammo="Staunch Tathlum +1",
        head="Souv. Schaller +1",neck="Moonbeam Necklace",ear1="Odnowa Earring +1",ear2="Knightly Earring",
        body="Rev. Surcoat +3",hands="Souv. Handsch. +1",ring1="Defending Ring",ring2="Moonlight Ring",
        back="Moonbeam Cape",waist="Flume Belt",legs="Founder's Hose",feet=gear.odyssean_fc_feet}

    sets.midcast.Flash = set_combine(sets.Enmity, {})
	sets.midcast.Flash.SIRD = set_combine(sets.Enmity.SIRD, {})
    sets.midcast.Stun = set_combine(sets.Enmity, {})
	sets.midcast.Stun.SIRD = set_combine(sets.Enmity.SIRD, {})
	sets.midcast['Blue Magic'] = set_combine(sets.Enmity, {})
	sets.midcast['Blue Magic'].SIRD = set_combine(sets.Enmity.SIRD, {})
	sets.midcast.Cocoon = set_combine(sets.Enmity.SIRD, {})

    sets.midcast.Cure = {ammo="Staunch Tathlum +1",
		head="Souv. Schaller +1",neck="Moonbeam Necklace",ear1="Nourish. Earring +1",ear2="Nourish. Earring",
		body="Souv. Cuirass +1",hands="Macabre Gaunt. +1",ring1="Defending Ring",ring2="Moonlight Ring",
		back="Moonbeam Cape",waist="Flume Belt",legs="Founder's Hose",feet=gear.odyssean_fc_feet}
		
    sets.midcast.Cure.SIRD = {ammo="Staunch Tathlum +1",
		head="Souv. Schaller +1",neck="Moonbeam Necklace",ear1="Nourish. Earring +1",ear2="Nourish. Earring",
		body="Souv. Cuirass +1",hands="Macabre Gaunt. +1",ring1="Defending Ring",ring2="Moonlight Ring",
		back="Moonbeam Cape",waist="Flume Belt",legs="Founder's Hose",feet=gear.odyssean_fc_feet}
		
    sets.midcast.Cure.DT = {ammo="Staunch Tathlum +1",
        head="Souv. Schaller +1",neck="Loricate Torque +1",ear1="Odnowa Earring +1",ear2="Nourish. Earring",
        body="Souv. Cuirass +1",hands="Souv. Handsch. +1",ring1="Defending Ring",ring2="Moonlight Ring",
        back="Moonbeam Cape",waist="Flume Belt",legs="Souv. Diechlings +1",feet="Souveran Schuhs +1"}
		
    sets.midcast.Reprisal = {ammo="Staunch Tathlum +1",
		head="Souv. Schaller +1",neck="Moonbeam Necklace",ear1="Odnowa Earring +1",ear2="Knightly Earring",
        body="Souv. Cuirass +1",hands="Souv. Handsch. +1",ring1="Defending Ring",ring2="Moonlight Ring",
        back="Moonbeam Cape",waist="Flume Belt",legs="Founder's Hose",feet=gear.odyssean_fc_feet}

	sets.Self_Healing = {ammo="Staunch Tathlum +1",
		head="Souv. Schaller +1",neck="Moonbeam Necklace",ear1="Nourish. Earring +1",ear2="Nourish. Earring",
		body="Souv. Cuirass +1",hands="Macabre Gaunt. +1",ring1="Defending Ring",ring2="Moonlight Ring",
		back="Moonbeam Cape",waist="Creed Baudrier",legs="Founder's Hose",feet=gear.odyssean_fc_feet}
		
	sets.Self_Healing.SIRD = {ammo="Staunch Tathlum +1",
		head="Souv. Schaller +1",neck="Moonbeam Necklace",ear1="Nourish. Earring +1",ear2="Nourish. Earring",
		body="Souv. Cuirass +1",hands="Macabre Gaunt. +1",ring1="Defending Ring",ring2="Moonlight Ring",
		back="Moonbeam Cape",waist="Creed Baudrier",legs="Founder's Hose",feet=gear.odyssean_fc_feet}
		
	sets.Self_Healing.DT = {ammo="Staunch Tathlum +1",
        head="Souv. Schaller +1",neck="Loricate Torque +1",ear1="Nourish. Earring +1",ear2="Nourish. Earring",
        body="Souv. Cuirass +1",hands="Souv. Handsch. +1",ring1="Defending Ring",ring2="Moonlight Ring",
        back="Moonbeam Cape",waist="Creed Baudrier",legs="Souv. Diechlings +1",feet="Souveran Schuhs +1"}

	sets.Cure_Received = {hands="Souv. Handsch. +1",feet="Souveran Schuhs +1"}
	sets.Self_Refresh = {}

    sets.midcast['Enhancing Magic'] = {ammo="Staunch Tathlum +1",
		head="Carmine Mask",neck="Moonbeam Necklace",ear1="Friomisi Earring",ear2="Knightly Earring",
		body="Souv. Cuirass +1",hands="Leyline Gloves",ring1="Defending Ring",ring2="Kishar Ring",
		back="Moonbeam Cape",waist="Tempus Fugit",legs="Founder's Hose",feet=gear.odyssean_fc_feet}
		
    sets.midcast['Enhancing Magic'].SIRD = {ammo="Staunch Tathlum +1",
		head="Souv. Schaller +1",neck="Moonbeam Necklace",ear1="Friomisi Earring",ear2="Knightly Earring",
		body="Souv. Cuirass +1",hands="Souv. Handsch. +1",ring1="Defending Ring",ring2="Kishar Ring",
		back="Moonbeam Cape",waist="Creed Baudrier",legs="Founder's Hose",feet=gear.odyssean_fc_feet}

	sets.midcast.Stoneskin = set_combine(sets.midcast['Enhancing Magic'], {})

    sets.midcast.Protect = set_combine(sets.midcast['Enhancing Magic'], {})
    sets.midcast.Shell = set_combine(sets.midcast['Enhancing Magic'], {})
	
	sets.midcast.Phalanx = set_combine(sets.midcast['Enhancing Magic'], {hands="Souv. Handsch. +1",feet="Souveran Schuhs +1"})
	sets.midcast.Phalanx.SIRD = set_combine(sets.midcast['Enhancing Magic'].SIRD, {hands="Souv. Handsch. +1",feet="Souveran Schuhs +1"})
	sets.midcast.Phalanx.DT = set_combine(sets.midcast.Phalanx.SIRD, {})	

	--------------------------------------
	-- Idle/resting/defense/etc sets
	--------------------------------------

    sets.resting = {ammo="Homiliary",
		head="Jumalik Helm",neck="Coatl Gorget +1",ear1="Etiolation Earring",ear2="Odnowa Earring",
		body="Jumalik Mail",hands="Souv. Handsch. +1",ring1="Defending Ring",ring2="Dark Ring",
		back="Moonbeam Cape",waist="Fucho-no-obi",legs="Sulev. Cuisses +2",feet="Cab. Leggings +1"}

    -- Idle sets
    sets.idle = {ammo="Staunch Tathlum +1",
		head="Souv. Schaller +1",neck="Loricate Torque +1",ear1="Odnowa Earring +1",ear2="Odnowa Earring",
		body="Souv. Cuirass +1",hands="Souv. Handsch. +1",ring1="Defending Ring",ring2="Gelatinous Ring +1",
		back="Moonbeam Cape",waist="Flume Belt",legs="Souv. Diechlings +1",feet="Souveran Schuhs +1"}
		
    sets.idle.PDT = {ammo="Staunch Tathlum +1",
		head="Souv. Schaller +1",neck="Loricate Torque +1",ear1="Odnowa Earring +1",ear2="Odnowa Earring",
		body="Souv. Cuirass +1",hands="Souv. Handsch. +1",ring1="Defending Ring",ring2="Gelatinous Ring +1",
		back="Moonbeam Cape",waist="Flume Belt",legs="Souv. Diechlings +1",feet="Souveran Schuhs +1"}
		
    sets.idle.MDT = {}
		
	sets.idle.Refresh = {}

	sets.idle.Tank = {}
		
	sets.idle.KiteTank = {}
		
    sets.idle.Reraise = {}
		
    sets.idle.Weak = {}
		
	sets.Kiting = {}

	sets.latent_refresh = {waist="Fucho-no-obi"}
	sets.latent_refresh_grip = {sub="Oneiros Grip"}
	sets.latent_regen = {ring1="Apeile Ring +1",ring2="Apeile Ring"}
	sets.DayIdle = {}
	sets.NightIdle = {}

	--------------------------------------
    -- Defense sets
    --------------------------------------
    
    -- Extra defense sets.  Apply these on top of melee or defense sets.
	sets.Knockback = {}
    sets.MP = {head="Chev. Armet +1",neck="Coatl Gorget +1",ear2="Ethereal Earring",waist="Flume Belt +1",feet="Rev. Leggings +3"}
	sets.passive.AbsorbMP = {head="Chev. Armet +1",neck="Coatl Gorget +1",ear2="Ethereal Earring",waist="Flume Belt +1",feet="Rev. Leggings +3"}
    sets.MP_Knockback = {}
    sets.Twilight = {head="Twilight Helm", body="Twilight Mail"}
	sets.TreasureHunter = set_combine(sets.TreasureHunter, {})
	
	-- Weapons sets
	sets.weapons.DeaconAegis = {main="Deacon Sword",sub="Aegis"}
	sets.weapons.SequenceBlurred = {main="Sequence",sub="Blurred Shield +1"}
	sets.weapons.SequenceAegis = {main="Sequence",sub="Aegis"}
	sets.weapons.DualWeapons = {main="Sequence",sub="Demersal Degen +1"}
    
    sets.defense.PDT = {sub="Priwen", ammo="Staunch Tathlum +1",
		head="Souv. Schaller +1",neck="Loricate Torque +1",ear1="Odnowa Earring +1",ear2="Odnowa Earring",
		body="Souv. Cuirass +1",hands="Souv. Handsch. +1",ring1="Defending Ring",ring2="Gelatinous Ring +1",
		back="Shadow Mantle",waist="Flume Belt",legs="Souv. Diechlings +1",feet="Souveran Schuhs +1"}
		
    -- sets.defense.PDT_HP = {sub="Priwen", ammo="Staunch Tathlum +1",
		-- head="Souv. Schaller +1",neck="Loricate Torque +1",ear1="Odnowa Earring +1",ear2="Odnowa Earring",
		-- body="Souv. Cuirass +1",hands="Souv. Handsch. +1",ring1="Defending Ring",ring2="Gelatinous Ring +1",
		-- back="Shadow Mantle",waist="Flume Belt",legs="Souv. Diechlings +1",feet="Souveran Schuhs +1"}
		
    -- sets.defense.MDT_HP = {sub="Aegis",ammo="Staunch Tathlum +1",
		-- head="Souv. Schaller +1",neck="Loricate Torque +1",ear1="Odnowa Earring +1",ear2="Odnowa Earring",
		-- body="Souv. Cuirass +1",hands="Souv. Handsch. +1",ring1="Defending Ring",ring2="Moonlight Ring",
		-- back="Engulfer's Cape +1",waist="Flume Belt",legs="Souv. Diechlings +1",feet="Souveran Schuhs +1"}
		
    -- sets.defense.MEVA_HP = {sub="Aegis",ammo="Staunch Tathlum +1",
		-- head="Souv. Schaller +1",neck="Loricate Torque +1",ear1="Odnowa Earring +1",ear2="Odnowa Earring",
		-- body="Souv. Cuirass +1",hands="Souv. Handsch. +1",ring1="Defending Ring",ring2="Moonlight Ring",
		-- back="Engulfer's Cape +1",waist="Flume Belt",legs="Souv. Diechlings +1",feet="Souveran Schuhs +1"}
		
    -- sets.defense.PDT_Reraise = {sub="Priwen", ammo="Staunch Tathlum +1",
		-- head="Souv. Schaller +1",neck="Loricate Torque +1",ear1="Odnowa Earring +1",ear2="Odnowa Earring",
		-- body="Souv. Cuirass +1",hands="Souv. Handsch. +1",ring1="Defending Ring",ring2="Gelatinous Ring +1",
		-- back="Shadow Mantle",waist="Flume Belt",legs="Souv. Diechlings +1",feet="Souveran Schuhs +1"}
		
    -- sets.defense.MDT_Reraise = {sub="Aegis",ammo="Staunch Tathlum +1",
		-- head="Souv. Schaller +1",neck="Loricate Torque +1",ear1="Odnowa Earring +1",ear2="Odnowa Earring",
		-- body="Souv. Cuirass +1",hands="Souv. Handsch. +1",ring1="Defending Ring",ring2="Moonlight Ring",
		-- back="Shadow Mantle",waist="Flume Belt",legs="Souv. Diechlings +1",feet="Souveran Schuhs +1"}

	sets.defense.MDT = {sub="Aegis",ammo="Staunch Tathlum +1",
		head="Souv. Schaller +1",neck="Loricate Torque +1",ear1="Odnowa Earring +1",ear2="Odnowa Earring",
		body="Souv. Cuirass +1",hands="Souv. Handsch. +1",ring1="Defending Ring",ring2="Moonlight Ring",
		back="Shadow Mantle",waist="Flume Belt",legs="Souv. Diechlings +1",feet="Souveran Schuhs +1"}
		
	-- sets.defense.Tank = {sub="Priwen",ammo="Staunch Tathlum +1",
		-- head="Souv. Schaller +1",neck="Loricate Torque +1",ear1="Odnowa Earring +1",ear2="Odnowa Earring",
		-- body="Souv. Cuirass +1",hands="Souv. Handsch. +1",ring1="Defending Ring",ring2="Gelatinous Ring +1",
		-- back="Shadow Mantle",waist="Flume Belt",legs="Souv. Diechlings +1",feet="Souveran Schuhs +1"}
		
	sets.defense.MEVA = {sub="Aegis",ammo="Staunch Tathlum +1",
		head="Souv. Schaller +1",neck="Loricate Torque +1",ear1="Odnowa Earring +1",ear2="Odnowa Earring",
		body="Souv. Cuirass +1",hands="Souv. Handsch. +1",ring1="Defending Ring",ring2="Moonlight Ring",
		back="Shadow Mantle",waist="Flume Belt",legs="Souv. Diechlings +1",feet="Souveran Schuhs +1"}
		
	-- sets.defense.Death = {}
		
	-- sets.defense.Charm = {}
		
		-- To cap MDT with Shell IV (52/256), need 76/256 in gear.
    -- Shellra V can provide 75/256, which would need another 53/256 in gear.
    -- sets.defense.OchainMDT = {sub="Aegis",ammo="Staunch Tathlum +1",
		-- head="Souv. Schaller +1",neck="Loricate Torque +1",ear1="Odnowa Earring +1",ear2="Odnowa Earring",
		-- body="Souv. Cuirass +1",hands="Souv. Handsch. +1",ring1="Defending Ring",ring2="Moonlight Ring",
		-- back="Shadow Mantle",waist="Flume Belt",legs="Souv. Diechlings +1",feet="Souveran Schuhs +1"}
		
    -- sets.defense.OchainNoShellMDT = {}
		
    -- sets.defense.AegisMDT = {sub="Aegis",ammo="Staunch Tathlum +1",
		-- head="Souv. Schaller +1",neck="Loricate Torque +1",ear1="Odnowa Earring +1",ear2="Odnowa Earring",
		-- body="Souv. Cuirass +1",hands="Souv. Handsch. +1",ring1="Defending Ring",ring2="Moonlight Ring",
		-- back="Shadow Mantle",waist="Flume Belt",legs="Souv. Diechlings +1",feet="Souveran Schuhs +1"}
		
    -- sets.defense.AegisNoShellMDT = {}		

	--------------------------------------
	-- Engaged sets
	--------------------------------------
    
	sets.engaged = {ammo="Aurgelmir Orb",
		head="Flam. Zucchetto +2",neck="Asperity Necklace",ear1="Cessance Earring",ear2="Telos Earring",
		body="Valorous Mail",hands="Sulev. Gauntlets +2",ring1="Flamma Ring",ring2="Chirich Ring +1",
		back="Kayapa Cape",waist="Windbuffet Belt +1",legs="Sulevi. Cuisses +1",feet="Flam. Gambieras +2"}

    sets.engaged.Acc = {ammo="Aurgelmir Orb",
        head="Flam. Zucchetto +2",neck="Asperity Necklace",ear1="Mache Earring +1",ear2="Telos Earring",
        body="Valorous Mail",hands="Sulev. Gauntlets +2",ring2="Chirich Ring +1",ring2="Chirich Ring +1",
        back="Kayapa Cape",waist="Windbuffet Belt +1",legs="Sulevi. Cuisses +1",feet="Flam. Gambieras +2"}

    -- sets.engaged.DW = {}

    -- sets.engaged.DW.Acc = {}

	sets.engaged.Tank = {ammo="Staunch Tathlum +1",
		head="Souv. Schaller +1",neck="Loricate Torque +1",ear1="Odnowa Earring",ear2="Odnowa Earring +1",
		body="Souv. Cuirass +1",hands="Souv. Handsch. +1",ring1="Defending Ring",ring2="Moonlight Ring",
		back="Shadow Mantle",waist="Flume Belt",legs="Souv. Diechlings +1",feet="Souveran Schuhs +1"}
		
	-- sets.engaged.Dawn = {}
		
	-- sets.engaged.BreathTank = {}
		
	sets.engaged.DDTank = {ammo="Aurgelmir Orb",
		head="Sulevia's Mask +1",neck="Loricate Torque +1",ear1="Cessance Earring",ear2="Telos Earring",
		body="Sulevia's Plate. +1",hands="Sulev. Gauntlets +2",ring1="Defending Ring",ring2="Moonlight Ring",
		back="Kayapa Cape",waist="Windbuffet Belt +1",legs="Sulev. Cuisses +1",feet="Sulev. Leggings +2"}
		
	-- sets.engaged.Acc.DDTank = {}
		
	-- sets.engaged.NoShellTank = {}
		
    sets.engaged.Reraise = set_combine(sets.engaged.Tank, sets.Reraise)
    sets.engaged.Acc.Reraise = set_combine(sets.engaged.Acc.Tank, sets.Reraise)
		
	--------------------------------------
	-- Custom buff sets
	--------------------------------------
	sets.buff.Doom = set_combine(sets.buff.Doom, {})
	sets.buff.Sleep = {neck="Vim Torque +1"}
    sets.buff.Cover = {body="Cab. Surcoat +1"}
end

-- Select default macro book on initial load or subjob change.
function select_default_macro_book()
    -- Default macro set/book
    if player.sub_job == 'NIN' then
        set_macro_page(2, 9)
    elseif player.sub_job == 'RUN' then
        set_macro_page(9, 9)
    elseif player.sub_job == 'RDM' then
        set_macro_page(6, 9)
    elseif player.sub_job == 'BLU' then
        set_macro_page(8, 9)
    elseif player.sub_job == 'DNC' then
        set_macro_page(4, 9)
    else
        set_macro_page(1, 9) --War/Etc
    end
end
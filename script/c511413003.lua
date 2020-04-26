--Yami闇 (Anime)
local s,id=GetID()
function s.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	c:RegisterEffect(e1)
	--Atk
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD)
	e2:SetCode(EFFECT_UPDATE_ATTACK)
	e2:SetRange(LOCATION_FZONE)
	e2:SetTargetRange(LOCATION_MZONE,0)
	e2:SetValue(s.val)
	c:RegisterEffect(e2)
	--Def
	local e3=e2:Clone()
	e3:SetCode(EFFECT_UPDATE_DEFENSE)
	e3:SetTargetRange(LOCATION_MZONE,LOCATION_MZONE)
	c:RegisterEffect(e3)
	--Shifting Shadows
	local e4=Effect.CreateEffect(c)
	e4:SetDescription(aux.Stringid(id,0))
	e4:SetType(EFFECT_TYPE_QUICK_O)
	e4:SetRange(LOCATION_FZONE)
	e4:SetCode(EVENT_FREE_CHAIN)
	e4:SetCountLimit(1)
	e4:SetTarget(s.target)
	e4:SetOperation(s.operation)
	c:RegisterEffect(e4)
	--Set Own Cards
	local e5=Effect.CreateEffect(c)
	e5:SetType(EFFECT_TYPE_FIELD)
	e5:SetRange(LOCATION_FZONE)
	e5:SetCode(EFFECT_SET_POSITION)
	e5:SetTarget(s.sfilter)
	e5:SetTargetRange(LOCATION_MZONE,0)
	e5:SetValue(POS_FACEDOWN_ATTACK)
	c:RegisterEffect(e5)
	local e6=e5:Clone()
	e6:SetTarget(s.s2filter)
	e6:SetValue(POS_FACEDOWN_DEFENSE)
	c:RegisterEffect(e6)
end
function s.val(e,c)
	local r=c:GetRace()
	if (r&RACE_FIEND+RACE_SPELLCASTER)>0 then return (c:GetAttack()*0.3)
	elseif (r&RACE_FAIRY)>0 then return (c:GetAttack()*-0.3)
	else return 0 end
end
function s.filter(c)
	return c:IsFacedown() and c:GetSequence()<5
end
function s.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(s.filter,tp,LOCATION_MZONE,0,2,nil) end
end
function s.operation(e,tp,eg,ep,ev,re,r,rp)
	if not e:GetHandler():IsRelateToEffect(e) then return end
	local g=Duel.GetMatchingGroup(s.filter,tp,LOCATION_MZONE,0,nil)
	Duel.ShuffleSetCard(g)
end
function s.sfilter(e,c)
	return c:IsFaceup() and c:IsPosition(POS_FACEUP_ATTACK)-- and not c:IsCode(62121)
end

function s.s2filter(e,c)
	return c:IsFaceup() and c:IsPosition(POS_FACEUP_DEFENSE)-- and not c:IsCode(62121)
end
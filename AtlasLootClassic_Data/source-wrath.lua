-----------------------------------------------------------------------
-- Upvalued Lua API.
-----------------------------------------------------------------------
local _G = getfenv(0)
local select = _G.select
local string = _G.string
local format = string.format

-- WoW

-- ----------------------------------------------------------------------------
-- AddOn namespace.
-- ----------------------------------------------------------------------------
local addonname = ...
local AtlasLoot = _G.AtlasLoot
if AtlasLoot:GameVersion_LT(AtlasLoot.WRATH_VERSION_NUM) then return end

--##START-DATA##
local SOURCE_DATA = {
	["AtlasLootIDs"] = {
		"AzjolNerub",
		"AhnKahet",
		"DrakTharonKeep",
		"Gundrak",
		"UtgardeKeep",
		"TheNexus",
		"TheOculus",
		"TheCullingOfStratholme",
		"VioletHold",
		"TStratholmeEpoch222",
		"TheEyeOfEternity"
	},
	["ItemData"] = {
		[21524] = {{2,4,1},{6,1,1}},
		[21525] = {7,2,1},
		[33330] = {5,3,1},
		[35570] = {5,1,1},
		[35571] = {5,1,1},
		[35572] = {5,1,1},
		[35573] = {5,2,1},
		[35574] = {5,2,1},
		[35575] = {5,2,1},
		[35576] = {5,3,1},
		[35577] = {5,3,1},
		[35578] = {5,3,1},
		[35579] = {5,4,1},
		[35580] = {5,4,1},
		[35583] = {4,1,1},
		[35584] = {4,1,1},
		[35585] = {4,1,1},
		[35587] = {4,3,1},
		[35588] = {4,3,1},
		[35589] = {4,3,1},
		[35590] = {4,2,1},
		[35591] = {4,2,1},
		[35592] = {4,2,1},
		[35593] = {4,6,1},
		[35594] = {4,6,1},
		[35595] = {6,5,1},
		[35596] = {6,5,1},
		[35597] = {6,5,1},
		[35598] = {6,2,1},
		[35599] = {6,2,1},
		[35600] = {6,2,1},
		[35601] = {6,3,1},
		[35602] = {6,3,1},
		[35603] = {6,3,1},
		[35604] = {6,1,1},
		[35605] = {6,1,1},
		[35606] = {2,1,1},
		[35607] = {2,1,1},
		[35608] = {2,1,1},
		[35609] = {2,2,1},
		[35610] = {2,2,1},
		[35611] = {2,2,1},
		[35612] = {2,5,1},
		[35613] = {2,5,1},
		[35614] = {2,5,1},
		[35615] = {2,6,1},
		[35616] = {2,6,1},
		[35617] = {6,1,1},
		[35618] = {3,1,1},
		[35619] = {3,1,1},
		[35620] = {3,1,1},
		[35630] = {3,2,1},
		[35631] = {3,2,1},
		[35632] = {3,2,1},
		[35633] = {3,3,1},
		[35634] = {3,3,1},
		[35635] = {3,3,1},
		[35636] = {3,4,1},
		[35637] = {3,4,1},
		[35638] = {3,4,1},
		[35639] = {3,5,1},
		[35640] = {3,5,1},
		[35641] = {3,5,1},
		[35642] = {9,3,1},
		[35643] = {9,4,1},
		[35644] = {9,3,1},
		[35645] = {9,6,1},
		[35646] = {9,6,1},
		[35647] = {9,4,1},
		[35649] = {9,7,1},
		[35650] = {9,7,1},
		[35651] = {9,7,1},
		[35652] = {[1] = 9,[2] = 8,[3] = 1,[5] = 1},
		[35653] = {[1] = 9,[2] = 8,[3] = 1,[5] = 1},
		[35654] = {[1] = 9,[2] = 8,[3] = 1,[5] = 1},
		[35655] = {1,1,1},
		[35656] = {1,1,1},
		[35657] = {1,1,1},
		[35658] = {1,2,1},
		[35659] = {1,2,1},
		[35660] = {1,2,1},
		[35661] = {1,3,1},
		[35662] = {1,3,1},
		[35663] = {1,3,1},
		[36943] = {7,1,1},
		[36944] = {7,1,1},
		[36945] = {7,1,1},
		[36946] = {7,1,1},
		[36947] = {7,3,1},
		[36948] = {7,3,1},
		[36949] = {7,3,1},
		[36950] = {7,3,1},
		[36951] = {7,2,1},
		[36952] = {7,2,1},
		[36953] = {7,2,1},
		[36954] = {7,2,1},
		[36961] = {7,4,1},
		[36962] = {7,4,1},
		[36969] = {7,4,1},
		[36971] = {7,4,1},
		[36972] = {7,4,1},
		[36973] = {7,4,1},
		[36974] = {7,4,1},
		[36975] = {7,4,1},
		[36976] = {7,5,1},
		[36977] = {7,5,1},
		[36978] = {7,5,1},
		[37079] = {8,2,1},
		[37081] = {8,2,1},
		[37082] = {8,2,1},
		[37083] = {8,2,1},
		[37084] = {8,1,1},
		[37086] = {8,1,1},
		[37088] = {8,1,1},
		[37095] = {8,1,1},
		[37096] = {8,3,1},
		[37099] = {8,3,1},
		[37105] = {8,3,1},
		[37106] = {8,3,1},
		[37107] = {8,4,1},
		[37108] = {8,4,1},
		[37109] = {8,4,1},
		[37110] = {8,4,1},
		[37111] = {8,4,1},
		[37112] = {8,4,1},
		[37113] = {8,4,1},
		[37114] = {8,4,1},
		[37115] = {{8,6,1},{10,2,1}},
		[37116] = {{8,6,1},{10,2,1}},
		[37117] = {{8,6,1},{10,2,1}},
		[37134] = {[1] = 6,[2] = 1,[3] = 1,[5] = 1},
		[37135] = {[1] = 6,[2] = 1,[3] = 1,[5] = 1},
		[37138] = {[1] = 6,[2] = 1,[3] = 1,[5] = 1},
		[37139] = {[1] = 6,[2] = 1,[3] = 1,[5] = 1},
		[37141] = {[1] = 6,[2] = 2,[3] = 1,[5] = 1},
		[37144] = {[1] = 6,[2] = 2,[3] = 1,[5] = 1},
		[37149] = {[1] = 6,[2] = 2,[3] = 1,[5] = 1},
		[37150] = {[1] = 6,[2] = 2,[3] = 1,[5] = 1},
		[37151] = {[1] = 6,[2] = 3,[3] = 1,[5] = 1},
		[37152] = {[1] = 6,[2] = 3,[3] = 1,[5] = 1},
		[37153] = {[1] = 6,[2] = 3,[3] = 1,[5] = 1},
		[37155] = {[1] = 6,[2] = 3,[3] = 1,[5] = 1},
		[37162] = {[1] = 6,[2] = 5,[3] = 1,[5] = 1},
		[37165] = {[1] = 6,[2] = 5,[3] = 1,[5] = 1},
		[37166] = {[1] = 6,[2] = 5,[3] = 1,[5] = 1},
		[37167] = {[1] = 6,[2] = 5,[3] = 1,[5] = 1},
		[37169] = {[1] = 6,[2] = 5,[3] = 1,[5] = 1},
		[37170] = {[1] = 6,[2] = 5,[3] = 1,[5] = 1},
		[37171] = {[1] = 6,[2] = 5,[3] = 1,[5] = 1},
		[37172] = {[1] = 6,[2] = 5,[3] = 1,[5] = 1},
		[37177] = {[1] = 5,[2] = 1,[3] = 1,[5] = 1},
		[37178] = {[1] = 5,[2] = 1,[3] = 1,[5] = 1},
		[37179] = {[1] = 5,[2] = 1,[3] = 1,[5] = 1},
		[37180] = {[1] = 5,[2] = 1,[3] = 1,[5] = 1},
		[37181] = {[1] = 5,[2] = 2,[3] = 1,[5] = 1},
		[37182] = {[1] = 5,[2] = 2,[3] = 1,[5] = 1},
		[37183] = {[1] = 5,[2] = 2,[3] = 1,[5] = 1},
		[37184] = {[1] = 5,[2] = 2,[3] = 1,[5] = 1},
		[37186] = {[1] = 5,[2] = 3,[3] = 1,[5] = 1},
		[37188] = {[1] = 5,[2] = 3,[3] = 1,[5] = 1},
		[37189] = {[1] = 5,[2] = 3,[3] = 1,[5] = 1},
		[37190] = {[1] = 5,[2] = 3,[3] = 1,[5] = 1},
		[37191] = {[1] = 5,[2] = 3,[3] = 1,[5] = 1},
		[37192] = {[1] = 5,[2] = 3,[3] = 1,[5] = 1},
		[37193] = {[1] = 5,[2] = 3,[3] = 1,[5] = 1},
		[37194] = {[1] = 5,[2] = 3,[3] = 1,[5] = 1},
		[37195] = {[1] = 7,[2] = 2,[3] = 1,[5] = 1},
		[37196] = {[1] = 5,[2] = 4,[3] = 1,[5] = 1},
		[37197] = {[1] = 5,[2] = 4,[3] = 1,[5] = 1},
		[37216] = {[1] = 1,[2] = 1,[3] = 1,[5] = 1},
		[37217] = {[1] = 1,[2] = 1,[3] = 1,[5] = 1},
		[37218] = {[1] = 1,[2] = 1,[3] = 1,[5] = 1},
		[37219] = {[1] = 1,[2] = 1,[3] = 1,[5] = 1},
		[37220] = {[1] = 1,[2] = 2,[3] = 1,[5] = 1},
		[37221] = {[1] = 1,[2] = 2,[3] = 1,[5] = 1},
		[37222] = {[1] = 1,[2] = 2,[3] = 1,[5] = 1},
		[37230] = {[1] = 1,[2] = 2,[3] = 1,[5] = 1},
		[37232] = {[1] = 1,[2] = 3,[3] = 1,[5] = 1},
		[37235] = {[1] = 1,[2] = 3,[3] = 1,[5] = 1},
		[37236] = {[1] = 1,[2] = 3,[3] = 1,[5] = 1},
		[37237] = {[1] = 1,[2] = 3,[3] = 1,[5] = 1},
		[37238] = {[1] = 1,[2] = 3,[3] = 1,[5] = 1},
		[37240] = {[1] = 1,[2] = 3,[3] = 1,[5] = 1},
		[37241] = {[1] = 1,[2] = 3,[3] = 1,[5] = 1},
		[37242] = {[1] = 1,[2] = 3,[3] = 1,[5] = 1},
		[37243] = {[1] = 1,[2] = 4,[3] = 1,[5] = 1},
		[37255] = {[1] = 7,[2] = 1,[3] = 1,[5] = 1},
		[37256] = {[1] = 7,[2] = 1,[3] = 1,[5] = 1},
		[37257] = {[1] = 7,[2] = 1,[3] = 1,[5] = 1},
		[37258] = {[1] = 7,[2] = 1,[3] = 1,[5] = 1},
		[37260] = {[1] = 7,[2] = 3,[3] = 1,[5] = 1},
		[37261] = {[1] = 7,[2] = 3,[3] = 1,[5] = 1},
		[37262] = {[1] = 7,[2] = 3,[3] = 1,[5] = 1},
		[37263] = {[1] = 7,[2] = 3,[3] = 1,[5] = 1},
		[37264] = {[1] = 7,[2] = 2,[3] = 1,[5] = 1},
		[37288] = {[1] = 7,[2] = 2,[3] = 1,[5] = 1},
		[37289] = {[1] = 7,[2] = 2,[3] = 1,[5] = 1},
		[37290] = {[1] = 7,[2] = 5,[3] = 1,[5] = 1},
		[37291] = {[1] = 7,[2] = 4,[3] = 1,[5] = 1},
		[37292] = {[1] = 7,[2] = 4,[3] = 1,[5] = 1},
		[37293] = {[1] = 7,[2] = 4,[3] = 1,[5] = 1},
		[37294] = {[1] = 7,[2] = 4,[3] = 1,[5] = 1},
		[37360] = {[1] = 7,[2] = 4,[3] = 1,[5] = 1},
		[37361] = {[1] = 7,[2] = 4,[3] = 1,[5] = 1},
		[37362] = {[1] = 7,[2] = 4,[3] = 1,[5] = 1},
		[37363] = {[1] = 7,[2] = 4,[3] = 1,[5] = 1},
		[37364] = {[1] = 7,[2] = 5,[3] = 1,[5] = 1},
		[37365] = {[1] = 7,[2] = 5,[3] = 1,[5] = 1},
		[37366] = {[1] = 7,[2] = 5,[3] = 1,[5] = 1},
		[37591] = {[1] = 2,[2] = 1,[3] = 1,[5] = 1},
		[37592] = {[1] = 2,[2] = 1,[3] = 1,[5] = 1},
		[37593] = {[1] = 2,[2] = 1,[3] = 1,[5] = 1},
		[37594] = {[1] = 2,[2] = 1,[3] = 1,[5] = 1},
		[37595] = {[1] = 2,[2] = 2,[3] = 1,[5] = 1},
		[37612] = {[1] = 2,[2] = 2,[3] = 1,[5] = 1},
		[37613] = {[1] = 2,[2] = 2,[3] = 1,[5] = 1},
		[37614] = {[1] = 2,[2] = 2,[3] = 1,[5] = 1},
		[37615] = {[1] = 2,[2] = 5,[3] = 1,[5] = 1},
		[37616] = {[1] = 2,[2] = 5,[3] = 1,[5] = 1},
		[37617] = {[1] = 2,[2] = 5,[3] = 1,[5] = 1},
		[37618] = {[1] = 2,[2] = 5,[3] = 1,[5] = 1},
		[37619] = {[1] = 2,[2] = 5,[3] = 1,[5] = 1},
		[37620] = {[1] = 2,[2] = 5,[3] = 1,[5] = 1},
		[37622] = {[1] = 2,[2] = 5,[3] = 1,[5] = 1},
		[37623] = {[1] = 2,[2] = 5,[3] = 1,[5] = 1},
		[37624] = {{[1] = 1,[2] = 4,[3] = 1,[5] = 1},{[1] = 2,[2] = 6,[3] = 1,[5] = 1}},
		[37625] = {{[1] = 1,[2] = 4,[3] = 1,[5] = 1},{[1] = 2,[2] = 6,[3] = 1,[5] = 1}},
		[37626] = {[1] = 4,[2] = 1,[3] = 1,[5] = 1},
		[37627] = {[1] = 4,[2] = 1,[3] = 1,[5] = 1},
		[37628] = {[1] = 4,[2] = 1,[3] = 1,[5] = 1},
		[37629] = {[1] = 4,[2] = 1,[3] = 1,[5] = 1},
		[37630] = {[1] = 4,[2] = 3,[3] = 1,[5] = 1},
		[37631] = {[1] = 4,[2] = 3,[3] = 1,[5] = 1},
		[37632] = {[1] = 4,[2] = 3,[3] = 1,[5] = 1},
		[37633] = {[1] = 4,[2] = 3,[3] = 1,[5] = 1},
		[37634] = {[1] = 4,[2] = 2,[3] = 1,[5] = 1},
		[37635] = {[1] = 4,[2] = 2,[3] = 1,[5] = 1},
		[37636] = {[1] = 4,[2] = 2,[3] = 1,[5] = 1},
		[37637] = {[1] = 4,[2] = 2,[3] = 1,[5] = 1},
		[37638] = {[1] = 4,[2] = 5,[3] = 1,[5] = 1},
		[37639] = {[1] = 4,[2] = 5,[3] = 1,[5] = 1},
		[37640] = {[1] = 4,[2] = 5,[3] = 1,[5] = 1},
		[37641] = {[1] = 4,[2] = 5,[3] = 1,[5] = 1},
		[37642] = {[1] = 4,[2] = 5,[3] = 1,[5] = 1},
		[37643] = {[1] = 4,[2] = 5,[3] = 1,[5] = 1},
		[37644] = {[1] = 4,[2] = 5,[3] = 1,[5] = 1},
		[37645] = {[1] = 4,[2] = 5,[3] = 1,[5] = 1},
		[37646] = {[1] = 4,[2] = 6,[3] = 1,[5] = 1},
		[37647] = {[1] = 4,[2] = 6,[3] = 1,[5] = 1},
		[37648] = {[1] = 4,[2] = 6,[3] = 1,[5] = 1},
		[37675] = {[1] = 8,[2] = 2,[3] = 1,[5] = 1},
		[37678] = {[1] = 8,[2] = 2,[3] = 1,[5] = 1},
		[37679] = {[1] = 8,[2] = 2,[3] = 1,[5] = 1},
		[37680] = {[1] = 8,[2] = 2,[3] = 1,[5] = 1},
		[37681] = {[1] = 8,[2] = 1,[3] = 1,[5] = 1},
		[37682] = {[1] = 8,[2] = 1,[3] = 1,[5] = 1},
		[37683] = {[1] = 8,[2] = 1,[3] = 1,[5] = 1},
		[37684] = {[1] = 8,[2] = 1,[3] = 1,[5] = 1},
		[37685] = {[1] = 8,[2] = 3,[3] = 1,[5] = 1},
		[37686] = {[1] = 8,[2] = 3,[3] = 1,[5] = 1},
		[37687] = {[1] = 8,[2] = 3,[3] = 1,[5] = 1},
		[37688] = {[1] = 8,[2] = 3,[3] = 1,[5] = 1},
		[37689] = {[1] = 8,[2] = 4,[3] = 1,[5] = 1},
		[37690] = {[1] = 8,[2] = 4,[3] = 1,[5] = 1},
		[37691] = {[1] = 8,[2] = 4,[3] = 1,[5] = 1},
		[37692] = {[1] = 8,[2] = 4,[3] = 1,[5] = 1},
		[37693] = {[1] = 8,[2] = 4,[3] = 1,[5] = 1},
		[37694] = {[1] = 8,[2] = 4,[3] = 1,[5] = 1},
		[37695] = {[1] = 8,[2] = 4,[3] = 1,[5] = 1},
		[37696] = {[1] = 8,[2] = 4,[3] = 1,[5] = 1},
		[37712] = {[1] = 3,[2] = 1,[3] = 1,[5] = 1},
		[37714] = {[1] = 3,[2] = 1,[3] = 1,[5] = 1},
		[37715] = {[1] = 3,[2] = 1,[3] = 1,[5] = 1},
		[37717] = {[1] = 3,[2] = 1,[3] = 1,[5] = 1},
		[37718] = {[1] = 3,[2] = 2,[3] = 1,[5] = 1},
		[37721] = {[1] = 3,[2] = 2,[3] = 1,[5] = 1},
		[37722] = {[1] = 3,[2] = 2,[3] = 1,[5] = 1},
		[37723] = {[1] = 3,[2] = 3,[3] = 1,[5] = 1},
		[37724] = {[1] = 3,[2] = 3,[3] = 1,[5] = 1},
		[37725] = {[1] = 3,[2] = 3,[3] = 1,[5] = 1},
		[37726] = {[1] = 3,[2] = 3,[3] = 1,[5] = 1},
		[37728] = {[1] = 6,[2] = 4,[3] = 1,[5] = 1},
		[37729] = {[1] = 6,[2] = 4,[3] = 1,[5] = 1},
		[37730] = {[1] = 6,[2] = 4,[3] = 1,[5] = 1},
		[37731] = {[1] = 6,[2] = 4,[3] = 1,[5] = 1},
		[37732] = {[1] = 3,[2] = 4,[3] = 1,[5] = 1},
		[37733] = {[1] = 3,[2] = 4,[3] = 1,[5] = 1},
		[37734] = {[1] = 3,[2] = 4,[3] = 1,[5] = 1},
		[37735] = {[1] = 3,[2] = 4,[3] = 1,[5] = 1},
		[37784] = {[1] = 3,[2] = 4,[3] = 1,[5] = 1},
		[37788] = {[1] = 3,[2] = 4,[3] = 1,[5] = 1},
		[37791] = {[1] = 3,[2] = 4,[3] = 1,[5] = 1},
		[37798] = {[1] = 3,[2] = 4,[3] = 1,[5] = 1},
		[37799] = {[1] = 3,[2] = 5,[3] = 1,[5] = 1},
		[37800] = {[1] = 3,[2] = 5,[3] = 1,[5] = 1},
		[37801] = {[1] = 3,[2] = 5,[3] = 1,[5] = 1},
		[37861] = {[1] = 9,[2] = 3,[3] = 1,[5] = 1},
		[37862] = {[1] = 9,[2] = 4,[3] = 1,[5] = 1},
		[37867] = {[1] = 9,[2] = 3,[3] = 1,[5] = 1},
		[37868] = {[1] = 9,[2] = 3,[3] = 1,[5] = 1},
		[37869] = {[1] = 9,[2] = 4,[3] = 1,[5] = 1},
		[37870] = {[1] = 9,[2] = 6,[3] = 1,[5] = 1},
		[37871] = {[1] = 9,[2] = 6,[3] = 1,[5] = 1},
		[37872] = {[1] = 9,[2] = 6,[3] = 1,[5] = 1},
		[37873] = {[1] = 9,[2] = 7,[3] = 1,[5] = 1},
		[37874] = {[1] = 9,[2] = 7,[3] = 1,[5] = 1},
		[37875] = {[1] = 9,[2] = 7,[3] = 1,[5] = 1},
		[37876] = {[1] = 9,[2] = 7,[3] = 1,[5] = 1},
		[37883] = {[1] = 9,[2] = 7,[3] = 1,[5] = 1},
		[37884] = {[1] = 9,[2] = 7,[3] = 1,[5] = 1},
		[37886] = {[1] = 9,[2] = 7,[3] = 1,[5] = 1},
		[37889] = {[1] = 9,[2] = 8,[3] = 1,[5] = 1},
		[37890] = {[1] = 9,[2] = 8,[3] = 1,[5] = 1},
		[37891] = {[1] = 9,[2] = 8,[3] = 1,[5] = 1},
		[40194] = {11,1,1},
		[40474] = {11,1,1},
		[40475] = {11,1,1},
		[40486] = {11,1,1},
		[40488] = {11,1,1},
		[40489] = {11,1,1},
		[40491] = {11,1,1},
		[40497] = {11,1,1},
		[40511] = {11,1,1},
		[40519] = {11,1,1},
		[40526] = {11,1,1},
		[40531] = {11,1,1},
		[40532] = {11,1,1},
		[40539] = {11,1,1},
		[40541] = {11,1,1},
		[40543] = {11,1,1},
		[40549] = {11,1,1},
		[40555] = {11,1,1},
		[40558] = {11,1,1},
		[40560] = {11,1,1},
		[40561] = {11,1,1},
		[40562] = {11,1,1},
		[40564] = {11,1,1},
		[40566] = {11,1,1},
		[40588] = {11,1,1},
		[40589] = {11,1,1},
		[40590] = {11,1,1},
		[40591] = {11,1,1},
		[40592] = {11,1,1},
		[40594] = {11,1,1},
		[41790] = {[1] = 2,[2] = 5,[3] = 1,[5] = 1},
		[41791] = {[1] = 9,[2] = 7,[3] = 1,[5] = 1},
		[41793] = {[1] = 5,[2] = 3,[3] = 1,[5] = 1},
		[41794] = {[1] = 6,[2] = 5,[3] = 1,[5] = 1},
		[41795] = {[1] = 3,[2] = 4,[3] = 1,[5] = 1},
		[41796] = {[1] = 1,[2] = 3,[3] = 1,[5] = 1},
		[41798] = {7,4,1},
		[43085] = {[1] = 8,[2] = 4,[3] = 1,[5] = 1},
		[43102] = {{[1] = 1,[2] = 3,[3] = 1,[5] = 1},{[1] = 2,[2] = 5,[3] = 1,[5] = 1},{[1] = 3,[2] = 4,[3] = 1,[5] = 1},{[1] = 4,[2] = 5,[3] = 1,[5] = 1},{[1] = 5,[2] = 3,[3] = 1,[5] = 1},{[1] = 6,[2] = 5,[3] = 1,[5] = 1},{[1] = 7,[2] = 4,[3] = 1,[5] = 1},{[1] = 8,[2] = 4,[3] = 1,[5] = 1},{[1] = 9,[2] = 7,[3] = 1,[5] = 1}},
		[43277] = {2,4,1},
		[43278] = {2,4,1},
		[43279] = {2,4,1},
		[43280] = {[1] = 2,[2] = 4,[3] = 1,[5] = 1},
		[43281] = {[1] = 2,[2] = 4,[3] = 1,[5] = 1},
		[43282] = {[1] = 2,[2] = 4,[3] = 1,[5] = 1},
		[43283] = {[1] = 2,[2] = 4,[3] = 1,[5] = 1},
		[43284] = {[1] = 2,[2] = 3,[3] = 1,[5] = 1},
		[43285] = {[1] = 2,[2] = 3,[3] = 1,[5] = 1},
		[43286] = {[1] = 2,[2] = 3,[3] = 1,[5] = 1},
		[43287] = {[1] = 2,[2] = 3,[3] = 1,[5] = 1},
		[43305] = {4,5,1},
		[43306] = {4,5,1},
		[43309] = {4,5,1},
		[43310] = {[1] = 4,[2] = 4,[3] = 1,[5] = 1},
		[43311] = {[1] = 4,[2] = 4,[3] = 1,[5] = 1},
		[43312] = {[1] = 4,[2] = 4,[3] = 1,[5] = 1},
		[43313] = {[1] = 4,[2] = 4,[3] = 1,[5] = 1},
		[43353] = {9,2,1},
		[43358] = {9,2,1},
		[43363] = {9,1,1},
		[43375] = {9,1,1},
		[43382] = {9,5,1},
		[43387] = {9,5,1},
		[43401] = {[1] = 9,[2] = 4,[3] = 1,[5] = 1},
		[43402] = {[1] = 9,[2] = 2,[3] = 1,[5] = 1},
		[43403] = {[1] = 9,[2] = 2,[3] = 1,[5] = 1},
		[43404] = {[1] = 9,[2] = 2,[3] = 1,[5] = 1},
		[43405] = {[1] = 9,[2] = 1,[3] = 1,[5] = 1},
		[43406] = {[1] = 9,[2] = 1,[3] = 1,[5] = 1},
		[43407] = {[1] = 9,[2] = 1,[3] = 1,[5] = 1},
		[43408] = {[1] = 9,[2] = 5,[3] = 1,[5] = 1},
		[43409] = {[1] = 9,[2] = 5,[3] = 1,[5] = 1},
		[43410] = {[1] = 9,[2] = 5,[3] = 1,[5] = 1},
		[43411] = {1,3,1},
		[43500] = {[1] = 9,[2] = 7,[3] = 1,[5] = 1},
		[43951] = {[1] = 8,[2] = 5,[3] = 1,[5] = 1},
		[43952] = {11,1,1},
		[44569] = {11,1,1},
		[44577] = {11,1,1},
		[44650] = {11,1,1},
		[44657] = {11,1,1},
		[44658] = {11,1,1},
		[44659] = {11,1,1},
		[44660] = {11,1,1},
		[44661] = {11,1,1},
		[44662] = {11,1,1},
		[44664] = {11,1,1},
		[44665] = {11,1,1},
		[47241] = {{[1] = 1,[2] = 1,[3] = 1,[5] = 1},{[1] = 1,[2] = 2,[3] = 1,[5] = 1},{[1] = 1,[2] = 3,[3] = 1,[5] = 1},{[1] = 2,[3] = 1,[5] = 1},{[1] = 3,[2] = 1,[3] = 1,[5] = 1},{[1] = 3,[2] = 2,[3] = 1,[5] = 1},{[1] = 3,[2] = 3,[3] = 1,[5] = 1},{[1] = 3,[2] = 4,[3] = 1,[5] = 1},{[1] = 4,[3] = 1,[5] = 1},{[1] = 5,[2] = 1,[3] = 1,[5] = 1},{[1] = 5,[2] = 2,[3] = 1,[5] = 1},{[1] = 5,[2] = 3,[3] = 1,[5] = 1},{[1] = 6,[3] = 1,[5] = 1},{[1] = 7,[2] = 1,[3] = 1,[5] = 1},{[1] = 7,[2] = 2,[3] = 1,[5] = 1},{[1] = 7,[2] = 3,[3] = 1,[5] = 1},{[1] = 7,[2] = 4,[3] = 1,[5] = 1},{[1] = 8,[3] = 1,[5] = 1},{[1] = 9,[3] = 1,[5] = 1}},
		[52676] = {[1] = 7,[2] = 4,[3] = 1,[5] = 1}
	}
}
--##END-DATA##
AtlasLoot.Addons:GetAddon("Sources"):SetData(SOURCE_DATA)
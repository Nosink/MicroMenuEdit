local _, ns = ...

ns.RegisterEnum("MicroButtons", {
    Character = "characterInfo",
    Profession = "professions",
    Spellbook = "spellbook",
    Talent = "talents",
    Legacy = "legacy",
    QuestLog = "questLog",
    Guild = "guildAndInformation",
    LFD = "groupFinder",
    Collections = "accountCollections",
    Store = "shop",
    MainMenu = "gameMenu"
})

ns.microButtonOrder = {
    "Character",
    "Profession",
    "Spellbook",
    "Talent",
    "Legacy",
    "QuestLog",
    "Guild",
    "LFD",
    "Collections",
    "Store",
    "MainMenu",
}

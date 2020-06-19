/// This class is used to get the extended name of a specific data.
class Acronym {

  /// Map from acronym to extended name.
  static final Map<String, String> _acronyms = {
    "aws":          "Apparent Wind Speed",
    "awa":          "Apparent Wind Angle",
    "sog":          "Speed Over Ground",
    "cog":          "Curse Over Ground",
    "mh":           "Magnetic Heading",
    "sow":          "Speed Over Water",
    "tws":          "True Wind Speed",
    "twa":          "True Wind Angle",
    "ih":           "imu_heading",
    "cang":         "calypso_ang",
    "camp":         "calypso_amp",
    "nwang":        "nwang",
  };

  /// Map from acronym to a short acronym.
  static final Map<String, String> _acronymsReduced = {
    "aws":          "aws",
    "awa":          "awa",
    "sog":          "sog",
    "cog":          "cog",
    "mh":           "mh",
    "sow":          "sow",
    "tws":          "tws",
    "twa":          "twa",
    "imu_heading":  "ih",
    "calypso_ang":  "cang",
    "calypso_amp":  "camp",
    "nwang":        "nwang",
  };

  /// This method allows to get the extended name.
  static String getExtendedName(String acronym) {
    return _acronyms[acronym];
  }

  /// This method allows to get the short acronym.
  static String reduceAcronym(String acronym) {
    return _acronymsReduced[acronym];
  }
}

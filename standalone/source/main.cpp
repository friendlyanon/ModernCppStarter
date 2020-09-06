#include <greeter/greeter.h>
#include <greeter/version.h>

#include <fmt/core.h>
#include <cxxopts.hpp>
#include <cstdio>
#include <string>
#include <unordered_map>

const std::unordered_map<std::string, greeter::LanguageCode> languages{
    {"en", greeter::LanguageCode::EN},
    {"de", greeter::LanguageCode::DE},
    {"es", greeter::LanguageCode::ES},
    {"fr", greeter::LanguageCode::FR},
};

int main(int argc, char** argv) {
  cxxopts::Options options(argv[0], "A program to welcome the world!");

  std::string language;
  std::string name;

  // clang-format off
  options.add_options()
    ("h,help", "Show help")
    ("v,version", "Print the current version number")
    ("n,name", "Name to greet", cxxopts::value(name)->default_value("World"))
    ("l,lang", "Language code to use", cxxopts::value(language)->default_value("en"))
  ;
  // clang-format on

  auto result = options.parse(argc, argv);

  if (result["help"].as<bool>()) {
    fmt::print("{}\n", options.help());
    return 0;
  } else if (result["version"].as<bool>()) {
    fmt::print("Greeter, version {}\n", GREETER_VERSION);
    return 0;
  }

  auto langIt = languages.find(language);
  if (langIt == languages.end()) {
    fmt::print(stderr, "unknown language code: {}\n", language);
    return 1;
  }

  greeter::Greeter greeter(name);
  fmt::print("{}\n", greeter.greet(langIt->second));

  return 0;
}

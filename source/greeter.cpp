#include <fmt/core.h>
#include <greeter/greeter.h>

using namespace greeter;

Greeter::Greeter(std::string _name) : name(_name) {}

std::string Greeter::greet(LanguageCode lang) const {
  const auto* greeting = [lang] {
    switch (lang) {
      default:
      case LanguageCode::EN:
        return "Hello, ";
      case LanguageCode::DE:
        return "Hallo ";
      case LanguageCode::ES:
        return "¡Hola ";
      case LanguageCode::FR:
        return "Bonjour ";
    }
  }();

  return fmt::format("{}{}!", greeting, name);
}

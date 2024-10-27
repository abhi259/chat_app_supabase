class RegexUtils {
  static final phoneRegex = RegExp(r'^[0-9]{10}$');
  static final emailRegex = RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$');
}

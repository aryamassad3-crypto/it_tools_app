import 'package:flutter/material.dart';
import 'package:it_tools_app/features/auth/presentation/pages/otp_verification_page.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _formKey = GlobalKey<FormState>();

  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _passwordController = TextEditingController();

  bool _obscurePassword = true;
  bool _acceptTerms = false;
  String? _selectedUniversity;

  final List<String> _universities = [
    'جامعة حلب - كلية الهندسة المعلوماتية',
    'المعهد التقاني للحاسوب',
    'جامعة أخرى',
  ];

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _submitRegister() {
    if (!_acceptTerms) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('يرجى الموافقة على الشروط والأحكام وسياسة الخصوصية'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    if (_formKey.currentState!.validate()) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => OtpVerificationPage(
            email: _emailController.text.trim(),
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFFFFF),
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        child: Directionality(
          textDirection: TextDirection.rtl,
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24.0),
            child: ConstrainedBox(
              constraints: BoxConstraints(
                minHeight: MediaQuery.of(context).size.height - MediaQuery.of(context).padding.top - 48,
              ),
              child: IntrinsicHeight(
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // رأس الصفحة: زر الرجوع على اليمين، والعنوان في المنتصف تماماً
                      Stack(
                        alignment: Alignment.center,
                        children: [
                          const Center(
                            child: Text(
                              'إنشاء حساب',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.black87,
                              ),
                            ),
                          ),
                          Align(
                            alignment: Alignment.centerRight,
                            child: IconButton(
                              onPressed: () => Navigator.pop(context),
                              icon: const Icon(Icons.arrow_forward_ios, size: 18, color: Colors.black87),
                              style: IconButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                  side: BorderSide(color: Colors.grey.shade300),
                                ),
                                padding: const EdgeInsets.all(10),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      
                      const Text(
                        'أنشئ حسابك خلال دقيقة واحدة لإتمام الطلب ومتابعته.',
                        style: TextStyle(fontSize: 13, color: Colors.grey),
                      ),
                      const SizedBox(height: 24),

                      // الاسم الكامل
                      const Text('الاسم الكامل', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500)),
                      const SizedBox(height: 8),
                      TextFormField(
                        controller: _nameController,
                        textAlign: TextAlign.right,
                        decoration: _inputDecoration(hint: 'أدخل الاسم الكامل', icon: Icons.person_outline),
                        validator: (val) => val == null || val.trim().isEmpty ? 'يرجى إدخال الاسم الكامل' : null,
                      ),
                      const SizedBox(height: 16),

                      // البريد الإلكتروني
                      const Text('البريد الإلكتروني', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500)),
                      const SizedBox(height: 8),
                      TextFormField(
                        controller: _emailController,
                        textAlign: TextAlign.right,
                        keyboardType: TextInputType.emailAddress,
                        decoration: _inputDecoration(hint: 'example@domain.com', icon: Icons.email_outlined),
                        validator: (val) {
                          if (val == null || val.trim().isEmpty) return 'يرجى إدخال البريد الإلكتروني';
                          if (!val.contains('@') || !val.contains('.')) return 'البريد الإلكتروني غير صالح';
                          return null;
                        },
                      ),
                      const SizedBox(height: 16),

                      // رقم الموبايل
                      const Text('رقم الموبايل', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500)),
                      const SizedBox(height: 8),
                      TextFormField(
                        controller: _phoneController,
                        textAlign: TextAlign.right,
                        keyboardType: TextInputType.phone,
                        decoration: _inputDecoration(hint: '09xxxxxxxx', icon: Icons.phone_outlined),
                        validator: (val) => val == null || val.trim().isEmpty ? 'يرجى إدخال رقم الموبايل' : null,
                      ),
                      const SizedBox(height: 16),

                      // كلمة المرور
                      const Text('كلمة المرور', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500)),
                      const SizedBox(height: 8),
                      TextFormField(
                        controller: _passwordController,
                        obscureText: _obscurePassword,
                        textAlign: TextAlign.right,
                        decoration: InputDecoration(
                          hintText: '••••••••',
                          hintStyle: const TextStyle(color: Colors.grey),
                          prefixIcon: IconButton(
                            icon: Icon(
                              _obscurePassword ? Icons.visibility_off_outlined : Icons.visibility_outlined,
                              color: Colors.grey,
                            ),
                            onPressed: () => setState(() => _obscurePassword = !_obscurePassword),
                          ),
                          border: _outlineBorder(Colors.grey),
                          enabledBorder: _outlineBorder(Colors.grey.shade300),
                          focusedBorder: _outlineBorder(const Color(0xFF0578B7), width: 2),
                          errorBorder: _outlineBorder(Colors.red),
                        ),
                        validator: (val) {
                          if (val == null || val.trim().isEmpty) return 'يرجى إدخال كلمة المرور';
                          if (val.length < 6) return 'كلمة المرور يجب ألا تقل عن 6 أحرف';
                          return null;
                        },
                      ),
                      const SizedBox(height: 16),

                      // الجامعة / المعهد (اختياري)
                      const Text('الجامعة / المعهد (اختياري)', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500)),
                      const SizedBox(height: 8),
                      DropdownButtonFormField<String>(
                        value: _selectedUniversity,
                        hint: const Text('اختر الجامعة أو المعهد', style: TextStyle(color: Colors.grey, fontSize: 14)),
                        decoration: _inputDecoration(hint: '', icon: null),
                        icon: const Icon(Icons.keyboard_arrow_down, color: Colors.grey),
                        items: _universities.map((uni) {
                          return DropdownMenuItem(
                            value: uni,
                            child: Text(uni, style: const TextStyle(fontSize: 14)),
                          );
                        }).toList(),
                        onChanged: (val) => setState(() => _selectedUniversity = val),
                      ),
                      const SizedBox(height: 10),

                      // صندوق التنبيه التوضيحي للجامعة
                      Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: const Color(0xFFE8F3FA),
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: const Color(0xFFCBE4F5)),
                        ),
                        child: const Row(
                          children: [
                            Icon(Icons.card_giftcard, color: Color(0xFF0578B7), size: 20),
                            SizedBox(width: 10),
                            Expanded(
                              child: Text(
                                'نستخدمها فقط لإرسال عروض وكوبونات خاصة بجامعتك.',
                                style: TextStyle(color: Color(0xFF0578B7), fontSize: 12),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 12),

                      // الموافقة على الشروط
                      Row(
                        children: [
                          Checkbox(
                            value: _acceptTerms,
                            activeColor: const Color(0xFF0578B7),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
                            onChanged: (val) => setState(() => _acceptTerms = val ?? false),
                          ),
                          const Text(
                            'أوافق على الشروط والأحكام وسياسة الخصوصية',
                            style: TextStyle(fontSize: 13, color: Colors.black87),
                          ),
                        ],
                      ),
                      
                      const Spacer(),
                      const SizedBox(height: 20),

                      // زر إنشاء الحساب
                      SizedBox(
                        width: double.infinity,
                        height: 50,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF0578B7),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                          ),
                          onPressed: _submitRegister,
                          child: const Text('إنشاء الحساب', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white)),
                        ),
                      ),
                      const SizedBox(height: 16),

                      // الانتقال لتسجيل الدخول
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text('لديك حساب؟ ', style: TextStyle(color: Colors.grey)),
                          GestureDetector(
                            onTap: () => Navigator.pop(context),
                            child: const Text(
                              'تسجيل الدخول',
                              style: TextStyle(color: Color(0xFF0578B7), fontWeight: FontWeight.bold),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  InputDecoration _inputDecoration({required String hint, IconData? icon}) {
    return InputDecoration(
      hintText: hint,
      hintStyle: const TextStyle(color: Colors.grey),
      prefixIcon: icon != null ? Icon(icon, color: Colors.grey) : null,
      border: _outlineBorder(Colors.grey),
      enabledBorder: _outlineBorder(Colors.grey.shade300),
      focusedBorder: _outlineBorder(const Color(0xFF0578B7), width: 2),
      errorBorder: _outlineBorder(Colors.red),
    );
  }

  OutlineInputBorder _outlineBorder(Color color, {double width = 1}) {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: BorderSide(color: color, width: width),
    );
  }
}
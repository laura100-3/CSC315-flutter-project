import 'package:flutter/material.dart';

class Login extends StatefulWidget {
  const Login({super.key});
  @override State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _formKey = GlobalKey<FormState>();
  final _emailCtrl = TextEditingController();
  final _passCtrl = TextEditingController();
  bool _obscure = true, _loading = false, _remember = false;

  Future<void> _login() async {
    if (_formKey.currentState!.validate()) {
      setState(() => _loading = true);
      await Future.delayed(const Duration(seconds: 2));
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Login successful!', style: TextStyle(color: Colors.white)), 
                        backgroundColor: Colors.green, behavior: SnackBarBehavior.floating));
      }
      setState(() => _loading = false);
    }
  }

  @override void dispose() {
    _emailCtrl.dispose();
    _passCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      appBar: AppBar(
        title: const Text('CSC315', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600)),
        backgroundColor: const Color(0xFF3B82F6),
        centerTitle: true,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              Container(width: 80, height: 80, decoration: BoxDecoration(color: const Color(0xFF3B82F6).withOpacity(0.1), shape: BoxShape.circle),
                       child: const Icon(Icons.school, size: 40, color: Color(0xFF3B82F6))),
              const SizedBox(height: 24),
              const Text('Hey you, Welcome Back', style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Color(0xFF1E293B))),
              const SizedBox(height: 8),
              Text('Sign in to your account', style: TextStyle(fontSize: 16, color: Color(0xFF64748B))),
              const SizedBox(height: 32),
              
              TextFormField(controller: _emailCtrl, decoration: _inputDecoration('Email', Icons.email_outlined),
                            keyboardType: TextInputType.emailAddress, textInputAction: TextInputAction.next,
                            validator: (v) => (v?.isEmpty ?? true) ? 'Email required' : null),
              const SizedBox(height: 16),
              
              TextFormField(controller: _passCtrl, obscureText: _obscure,
                            decoration: _inputDecoration('Password', Icons.lock_outlined, 
                            suffix: IconButton(icon: Icon(_obscure ? Icons.visibility_off : Icons.visibility),
                                              onPressed: () => setState(() => _obscure = !_obscure))),
                            textInputAction: TextInputAction.done, onFieldSubmitted: (_) => _login(),
                            validator: (v) => (v?.isEmpty ?? true) ? 'Password required' : (v!.length < 6) ? 'Min 6 chars' : null),
              const SizedBox(height: 20),
              
              Row(children: [
                Row(children: [Checkbox(value: _remember, onChanged: (v) => setState(() => _remember = v ?? false),
                                       activeColor: Color(0xFF3B82F6)), const Text('Remember', style: TextStyle(color: Color(0xFF64748B)))]),
                const Spacer(),
                TextButton(onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const ForgetPassword())),
                          child: const Text('Forgot Password?', style: TextStyle(color: Color(0xFF3B82F6))))
              ]),
              const SizedBox(height: 24),
              
              SizedBox(width: double.infinity, height: 50,
                      child: ElevatedButton(onPressed: _loading ? null : _login,
                                           style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF3B82F6),
                                                                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12))),
                                           child: _loading ? const SizedBox(width: 20, height: 20, child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2))
                                                         : const Text('Sign In', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)))),
              const SizedBox(height: 24),
              
              RichText(text: TextSpan(style: const TextStyle(color: Color(0xFF64748B)),
                                     children: [const TextSpan(text: "Don't have an account? "),
                                               TextSpan(text: 'Sign Up', style: const TextStyle(color: Color(0xFF3B82F6), fontWeight: FontWeight.w600))]))
            ],
          ),
        ),
      ),
    );
  }

  InputDecoration _inputDecoration(String label, IconData icon, {Widget? suffix}) => InputDecoration(
    labelText: label, prefixIcon: Icon(icon, color: const Color(0xFF64748B)),
    filled: true, fillColor: Colors.white, contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
    border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide(color: Colors.grey.shade200)),
    enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide(color: Colors.grey.shade200)),
    focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: const BorderSide(color: Color(0xFF3B82F6))),
    errorBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: const BorderSide(color: Colors.red)),
    suffixIcon: suffix,
  );
}

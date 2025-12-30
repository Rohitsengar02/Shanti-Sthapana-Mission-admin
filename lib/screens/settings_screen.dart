import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildHeader(),
          const SizedBox(height: 30),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(child: _buildNGOProfile()),
              const SizedBox(width: 30),
              Expanded(child: _buildPaymentSettings()),
            ],
          ),
          const SizedBox(height: 30),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(child: _buildWebsiteSettings()),
              const SizedBox(width: 30),
              Expanded(child: _buildGeneralSettings()),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Settings',
              style: GoogleFonts.oswald(
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              'Configure your NGO admin panel',
              style: TextStyle(color: Colors.grey[600]),
            ),
          ],
        ),
        ElevatedButton.icon(
          onPressed: () {},
          icon: const Icon(Icons.save),
          label: const Text('SAVE CHANGES'),
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF00D494),
            foregroundColor: Colors.white,
            padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 15),
          ),
        ),
      ],
    );
  }

  Widget _buildNGOProfile() {
    return Container(
      padding: const EdgeInsets.all(30),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.03), blurRadius: 20),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(Icons.business, color: Color(0xFF6C5CE7)),
              const SizedBox(width: 10),
              Text(
                'NGO Profile',
                style: GoogleFonts.oswald(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 30),
          Row(
            children: [
              Container(
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                  color: const Color(0xFF6C5CE7).withOpacity(0.1),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: const Icon(
                  Icons.camera_alt,
                  color: Color(0xFF6C5CE7),
                  size: 30,
                ),
              ),
              const SizedBox(width: 20),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Organization Logo',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    'PNG, JPG up to 2MB',
                    style: TextStyle(color: Colors.grey[500], fontSize: 12),
                  ),
                  const SizedBox(height: 10),
                  TextButton(
                    onPressed: () {},
                    child: const Text('Change Logo'),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 25),
          _textField('Organization Name', 'Shanti Sthapna Mission'),
          _textField('Tagline', 'Building Hope, Changing Lives'),
          _textField('Registration Number', 'NGO/2020/12345'),
          _textField('Address', '123 Charity Lane, New Delhi, India'),
          _textField('Contact Email', 'contact@shantimission.org'),
          _textField('Phone', '+91 98765 43210'),
        ],
      ),
    );
  }

  Widget _buildPaymentSettings() {
    return Container(
      padding: const EdgeInsets.all(30),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.03), blurRadius: 20),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(Icons.payment, color: Color(0xFF00D494)),
              const SizedBox(width: 10),
              Text(
                'Payment Settings',
                style: GoogleFonts.oswald(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 30),
          _textField('Bank Name', 'State Bank of India'),
          _textField('Account Number', 'XXXX XXXX XXXX 4567'),
          _textField('IFSC Code', 'SBIN0001234'),
          _textField('Account Holder', 'Shanti Sthapna Mission Trust'),
          const SizedBox(height: 20),
          const Text(
            'Payment Gateways',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 15),
          _paymentGateway('Razorpay', true, const Color(0xFF0066FF)),
          _paymentGateway('PayU', false, const Color(0xFF00D494)),
          _paymentGateway('Stripe', false, const Color(0xFF6C5CE7)),
          const SizedBox(height: 20),
          _textField('Razorpay Key ID', 'rzp_live_xxxxxxxx'),
          _textField('Razorpay Secret', '••••••••••••'),
        ],
      ),
    );
  }

  Widget _paymentGateway(String name, bool isActive, Color color) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 12),
      decoration: BoxDecoration(
        border: Border.all(color: isActive ? color : Colors.grey[200]!),
        borderRadius: BorderRadius.circular(10),
        color: isActive ? color.withOpacity(0.05) : null,
      ),
      child: Row(
        children: [
          Icon(Icons.payment, color: isActive ? color : Colors.grey),
          const SizedBox(width: 12),
          Text(
            name,
            style: TextStyle(
              fontWeight: FontWeight.w600,
              color: isActive ? color : Colors.grey,
            ),
          ),
          const Spacer(),
          Switch(value: isActive, onChanged: (val) {}, activeColor: color),
        ],
      ),
    );
  }

  Widget _buildWebsiteSettings() {
    return Container(
      padding: const EdgeInsets.all(30),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.03), blurRadius: 20),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(Icons.web, color: Color(0xFFFFB800)),
              const SizedBox(width: 10),
              Text(
                'Website & SEO',
                style: GoogleFonts.oswald(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 30),
          _textField('Site Title', 'Shanti Sthapna Mission - NGO'),
          _textField(
            'Meta Description',
            'Join us in building hope and changing lives through education, healthcare, and community development.',
          ),
          _textField('Website URL', 'https://shantimission.org'),
          const SizedBox(height: 20),
          const Text(
            'Analytics Integration',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 15),
          _textField('Google Analytics ID', 'UA-XXXXXXXXX-X'),
          _textField('Facebook Pixel ID', 'XXXXXXXXXXXXXXX'),
          const SizedBox(height: 20),
          Row(
            children: [
              Expanded(child: _actionButton('Generate Sitemap', Icons.map)),
              const SizedBox(width: 15),
              Expanded(
                child: _actionButton('Clear Cache', Icons.cleaning_services),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildGeneralSettings() {
    return Container(
      padding: const EdgeInsets.all(30),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.03), blurRadius: 20),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(Icons.settings, color: Color(0xFF00C7E2)),
              const SizedBox(width: 10),
              Text(
                'General Settings',
                style: GoogleFonts.oswald(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 30),
          _switchSetting('Enable Donations', true),
          _switchSetting('Volunteer Signups', true),
          _switchSetting('Event Registration', true),
          _switchSetting('Newsletter Popup', false),
          _switchSetting('Maintenance Mode', false),
          const SizedBox(height: 20),
          const Text(
            'Currency & Locale',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 15),
          _dropdownField('Currency', 'INR (₹)'),
          _dropdownField('Language', 'English'),
          _dropdownField('Timezone', 'Asia/Kolkata (IST)'),
          const SizedBox(height: 20),
          Row(
            children: [
              Expanded(child: _actionButton('Backup Data', Icons.backup)),
              const SizedBox(width: 15),
              Expanded(child: _actionButton('Restore', Icons.restore)),
            ],
          ),
        ],
      ),
    );
  }

  Widget _textField(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: TextField(
        controller: TextEditingController(text: value),
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
        ),
      ),
    );
  }

  Widget _switchSetting(String label, bool value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: const TextStyle(fontWeight: FontWeight.w500)),
          Switch(
            value: value,
            onChanged: (val) {},
            activeColor: const Color(0xFF00D494),
          ),
        ],
      ),
    );
  }

  Widget _dropdownField(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 12),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey[300]!),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: TextStyle(color: Colors.grey[600], fontSize: 12),
                ),
                const SizedBox(height: 3),
                Text(
                  value,
                  style: const TextStyle(fontWeight: FontWeight.w500),
                ),
              ],
            ),
            const Icon(Icons.arrow_drop_down),
          ],
        ),
      ),
    );
  }

  Widget _actionButton(String label, IconData icon) {
    return OutlinedButton.icon(
      onPressed: () {},
      icon: Icon(icon, size: 18),
      label: Text(label),
      style: OutlinedButton.styleFrom(
        padding: const EdgeInsets.symmetric(vertical: 15),
      ),
    );
  }
}

name: Deploy to GitHub Pages

on:
  push:
    branches: [ main ]

jobs:
  deploy:
    runs-on: ubuntu-latest
    steps:
    - uses: actions/checkout@v4
    
    - name: Set up Flutter
      uses: subosito/flutter-action@v2
      with:
        flutter-version: '3.19.0'
        
    - name: Install dependencies
      run: flutter pub get
      
    - name: Build with secrets
      run: |
        flutter build web \
          --release \
          --base-href /supa_chat/ \
          --dart-define=SUPABASE_URL=${{ secrets.SUPABASE_URL }} \
          --dart-define=SUPABASE_ANON_KEY=${{ secrets.SUPABASE_ANON_KEY }} \
          --no-tree-shake-icons
          
    - name: Deploy to Pages
      uses: peaceiris/actions-gh-pages@v3
      with:
        github_token: ${{ secrets.GITHUB_TOKEN }}
        publish_dir: ./build/web
        keep_files: false
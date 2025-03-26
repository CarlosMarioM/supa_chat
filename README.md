# SupaChat - Flutter & Supabase Realtime Chat

![SupaChat Banner](https://imgs.search.brave.com/OPII0jh6hUDctO_9zDf0Yy6U6WUwrUC04xSCkW-Iteo/rs:fit:500:0:0:0/g:ce/aHR0cHM6Ly9zdHls/ZXMucmVkZGl0bWVk/aWEuY29tL3Q1XzQ3/ZGEzbC9zdHlsZXMv/Y29tbXVuaXR5SWNv/bl84d2Jxa3Awcm96/amQxLmpwZz9mb3Jt/YXQ9cGpwZyZzPTcw/ODYyZWVjOWMyOWFh/MGMyNWYyYTZiOWU3/MDg2OThkZDAzNDc0/ZTU)

A feature-rich chat application built with Flutter and Supabase, showcasing realtime functionality with optimized performance.

## ✨ Features

- Realtime messaging with typing indicators
- Interactive emoji reactions
- Beautiful UI with animations

## 🚀 Getting Started

### Prerequisites
- Flutter 3.0+
- Dart 2.17+
- Supabase account

### Installation
```bash
git clone https://github.com/yourusername/supachat.git
cd supachat
flutter pub get
```

## 🛠️ Supabase Setup

1. Create a new project at [supabase.com](https://supabase.com).
2. Run these SQL commands in the Supabase SQL Editor:

```sql
create table if not exists public.profiles (
    id uuid references auth.users on delete cascade not null primary key,
    username varchar(24) not null unique,
    created_at timestamp with time zone default timezone('utc' :: text, now()) not null,
    constraint username_validation check (username ~* '^[A-Za-z0-9_]{3,24}$')
);
comment on table public.profiles is 'Holds all of users profile information';

create table if not exists public.rooms (
    id uuid not null primary key default gen_random_uuid(),
    value varchar(24) not null unique,
    created_at timestamp with time zone default timezone('utc' :: text, now()) not null
);
comment on table public.rooms is 'Holds information about chat rooms.';

create table if not exists public.messages (
    id uuid not null primary key default gen_random_uuid(),
    profile_id uuid default auth.uid() references public.profiles(id) on delete cascade not null,
    room_id uuid default auth.uid() references public.rooms(id) on delete cascade not null,
    content varchar(500) not null,
    created_at timestamp with time zone default timezone('utc' :: text, now()) not null
);
comment on table public.messages is 'Holds individual messages sent on the app.';

create table if not exists public.reactions (
    id uuid not null primary key default gen_random_uuid(),
    message_id uuid default auth.uid() references public.messages(id) on delete cascade not null,
    profile_id uuid default auth.uid() references public.profiles(id) on delete cascade not null, 
    value varchar(20) not null,
    created_at timestamp with time zone default timezone('utc' :: text, now()) not null
);
comment on table public.reactions is 'Holds individual reactions to every message.';

-- *** Add tables to the publication to enable real time subscription ***
alter publication supabase_realtime add table public.messages;
alter publication supabase_realtime add table public.reactions;
alter publication supabase_realtime add table public.rooms;

-- Function to create a new row in profiles table upon signup
-- Also copies the username value from metadata
create or replace function handle_new_user() returns trigger as $$
    begin
        insert into public.profiles(id, username)
        values(new.id, new.raw_user_meta_data->>'username');

        return new;
    end;
$$ language plpgsql security definer;

-- Trigger to call `handle_new_user` when new user signs up
create trigger on_auth_user_created
    after insert on auth.users
    for each row
    execute function handle_new_user();
```

3. Create a `.env` file in your project directory with your Supabase credentials:

```env
SUPABASE_URL=your-supabase-url
SUPABASE_ANON_KEY=your-anon-key
```

## 🛠️ Key Implementations

### Realtime Streams

```dart
// Messages stream
final messagesStream = supabase
    .from('messages')
    .stream(primaryKey: ['id'])
    .eq('room_id', widget.room.id)
    .order('created_at');

// Reactions stream
final reactionsStream = supabase
    .from('reactions')
    .stream(primaryKey: ['id'])
    .eq('message_id', message.id)
    .order('created_at');
```

## 📱 Screenshots

| Chat View | Reactions | Profile |
|------------|-----------|---------|
| ![Chat](https://placehold.co/300x600?text=Chat) | ![Reactions](https://placehold.co/300x600?text=Reactions) | ![Profile](https://placehold.co/300x600?text=Profile) |

## 📚 Resources

- [Flutter Documentation](https://flutter.dev/docs)
- [Supabase Flutter Docs](https://supabase.com/docs/guides/getting-started/flutter)
- [Supabase Realtime](https://supabase.com/docs/guides/realtime)

## 🤝 Contributing

Contributions welcome! Please open an issue first to discuss major changes.



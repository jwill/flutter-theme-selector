import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:signals/signals_flutter.dart';

abstract class KeyValueStore {
  Future<void> setItem(String key, String value);
  Future<String?> getItem(String key);
  Future<void> removeItem(String key);
}

class SharedPreferencesStore implements KeyValueStore {
  SharedPreferencesStore(this.preferences);
  SharedPreferencesWithCache preferences;

  @override
  Future<String?> getItem(String key) async {
    return preferences.getString(key);
  }

  @override
  Future<void> removeItem(String key) async {
    preferences.remove(key);
  }

  @override
  Future<void> setItem(String key, String value) async {
    preferences.setString(key, value);
  }
}

class PersistedSignal<T, KV extends KeyValueStore> extends FlutterSignal<T>
    with PersistedSignalMixin<T, KV> {
  PersistedSignal(
    super.internalValue, {
    super.autoDispose,
    super.debugLabel,
    required this.key,
    required this.store,
  });

  @override
  final String key;

  @override
  final KV store;
}

mixin PersistedSignalMixin<T, KV extends KeyValueStore> on Signal<T> {
  String get key;
  KV get store;

  bool loaded = false;

  Future<void> init() async {
    try {
      final val = await load();
      super.value = val;
    } catch (e) {
      debugPrint('Error loading persisted signal: $e');
    } finally {
      loaded = true;
    }
  }

  @override
  T get value {
    if (!loaded) init().ignore();
    return super.value;
  }

  @override
  set value(T value) {
    super.value = value;
    save(value).ignore();
  }

  Future<T> load() async {
    final val = await store.getItem(key);
    if (val == null) return value;
    return decode(val);
  }

  Future<void> save(T value) async {
    final str = encode(value);
    await store.setItem(key, str);
  }

  T decode(String value) => jsonDecode(value);

  String encode(T value) => jsonEncode(value);
}

class EnumSignal<T extends Enum>
    extends PersistedSignal<T, SharedPreferencesStore> {
  EnumSignal(super.val, String key, this.values, SharedPreferencesStore store)
      : super(
          key: key,
          store: store,
        );

  final List<T> values;

  @override
  T decode(String value) => values.firstWhere((e) => e.name == value);

  @override
  String encode(T value) => value.name;
}

class SettingsSignal extends PersistedSignal<String, SharedPreferencesStore> {
  SettingsSignal(super.val, String key, SharedPreferencesStore store)
      : super(
          key: key,
          store: store,
        );

  @override
  String encode(String value) => value;

  @override
  String decode(String value) => value;
}

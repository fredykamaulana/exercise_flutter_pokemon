// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pokemon_list_riverpod.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(pokemonService)
const pokemonServiceProvider = PokemonServiceProvider._();

final class PokemonServiceProvider
    extends $FunctionalProvider<PokemonService, PokemonService, PokemonService>
    with $Provider<PokemonService> {
  const PokemonServiceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'pokemonServiceProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$pokemonServiceHash();

  @$internal
  @override
  $ProviderElement<PokemonService> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  PokemonService create(Ref ref) {
    return pokemonService(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(PokemonService value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<PokemonService>(value),
    );
  }
}

String _$pokemonServiceHash() => r'5b5065e93ee76f71013384b3b030ade26ad215fa';

@ProviderFor(pageCount)
const pageCountProvider = PageCountProvider._();

final class PageCountProvider extends $FunctionalProvider<int, int, int>
    with $Provider<int> {
  const PageCountProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'pageCountProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$pageCountHash();

  @$internal
  @override
  $ProviderElement<int> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  int create(Ref ref) {
    return pageCount(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(int value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<int>(value),
    );
  }
}

String _$pageCountHash() => r'70d7545b4f2f66fa613923b711beb360b838159a';

@ProviderFor(getPokemonList)
const getPokemonListProvider = GetPokemonListProvider._();

final class GetPokemonListProvider
    extends
        $FunctionalProvider<
          AsyncValue<RemoteState>,
          RemoteState,
          FutureOr<RemoteState>
        >
    with $FutureModifier<RemoteState>, $FutureProvider<RemoteState> {
  const GetPokemonListProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'getPokemonListProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$getPokemonListHash();

  @$internal
  @override
  $FutureProviderElement<RemoteState> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<RemoteState> create(Ref ref) {
    return getPokemonList(ref);
  }
}

String _$getPokemonListHash() => r'c2aa67e53c633f5155e307d3787f9be48990606c';

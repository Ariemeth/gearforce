# Unit JSON Loading Benchmarks

This document describes the benchmark tests for measuring the performance of loading and parsing units from JSON files.

## Files

- **`test/data/repositories/unit_loading_benchmark.dart`** - Comprehensive benchmarks for JSON parsing and unit loading performance

## Running the Benchmarks

### Unit Test Benchmarks (Fast, no device needed)

```bash
# Run all benchmarks
flutter test test/data/repositories/unit_loading_benchmark.dart

# Run tests with output
flutter test test/data/repositories/unit_loading_benchmark.dart --verbose
```

**What it measures:**
- **JSON decoding time** - How long it takes to parse the JSON file
- **Unit parsing time** - Total time to deserialize all units into Dart objects
- **Average per-unit parsing** - Individual unit deserialization performance
- **Complex unit parsing** - Performance for units with variants, upgrades, and weapons
- **Repository caching** - How effective the in-memory cache is (cold vs hot loads)
- **Unit characteristics** - Distribution of variants, upgrades, and weapons across units

## Benchmark Output Example

```
=== Unit JSON Loading Benchmark ===
File size: 456789 bytes
JSON parsing time: 45ms
Unit count: 125
Total unit parsing time: 230ms
Average time per unit: 1.84ms

First unit: Jaguar
  - Variants: 3
  - Upgrades: 8
  - React weapons: 2
  - Mounted weapons: 4

Cache hit time: 2ms
Performance improvement: 115x faster
```

## Performance Goals

- **JSON parsing:** < 50ms for typical faction file
- **Unit parsing:** < 2ms per unit average
- **Total faction load:** < 300ms
- **Cache hit:** < 5ms

## Optimization Opportunities

If benchmarks reveal slow performance, consider:

1. **Lazy loading** - Load units on-demand rather than all at startup
2. **Async parsing** - Parse units in background isolate
3. **JSON structure** - Simplify or pre-process JSON format
4. **Converter optimization** - Profile custom JSON converters (weapons, traits)

## Tracking Performance Over Time

To track performance across releases:

```bash
# Run benchmarks and save output
flutter test test/data/repositories/unit_loading_benchmark.dart 2>&1 | tee benchmark_results_$(date +%Y%m%d).txt
```

## See Also

- [Flutter Performance Profiling](https://flutter.dev/docs/perf/rendering/ui-performance)
- [JSON Performance Best Practices](https://dart.dev/guides/json)

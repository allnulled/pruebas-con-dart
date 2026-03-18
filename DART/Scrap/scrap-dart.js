// ==UserScript==
// @name     Scrap de Flutter y Dart API
// @version  1
// @grant    none
// ==/UserScript==

window.ScrapTargets = [
  "https://api.flutter.dev/flutter/animation/",
  "https://api.flutter.dev/flutter/cupertino/",
  "https://api.flutter.dev/flutter/foundation/",
  "https://api.flutter.dev/flutter/gestures/",
  "https://api.flutter.dev/flutter/material/",
  "https://api.flutter.dev/flutter/painting/",
  "https://api.flutter.dev/flutter/physics/",
  "https://api.flutter.dev/flutter/rendering/",
  "https://api.flutter.dev/flutter/scheduler/",
  "https://api.flutter.dev/flutter/semantics/",
  "https://api.flutter.dev/flutter/services/",
  "https://api.flutter.dev/flutter/widget_previews/",
  "https://api.flutter.dev/flutter/widgets/",
  "https://api.flutter.dev/flutter/dart-ui/",
  "https://api.flutter.dev/flutter/dart-ui_web/",
  "https://api.flutter.dev/flutter/dart-async/",
  "https://api.flutter.dev/flutter/dart-collection/",
  "https://api.flutter.dev/flutter/dart-convert/",
  "https://api.flutter.dev/flutter/dart-core/",
  "https://api.flutter.dev/flutter/dart-developer/",
  "https://api.flutter.dev/flutter/dart-math/",
  "https://api.flutter.dev/flutter/dart-typed_data/",
  "https://api.flutter.dev/flutter/dart-ffi/",
  "https://api.flutter.dev/flutter/dart-io/",
  "https://api.flutter.dev/flutter/dart-isolate/",
  "https://api.flutter.dev/flutter/dart-js_interop/",
  "https://api.flutter.dev/flutter/dart-js_interop_unsafe/",
  "https://api.flutter.dev/flutter/dart-html/",
  "https://api.flutter.dev/flutter/dart-js/",
  "https://api.flutter.dev/flutter/Android/",
  "https://api.flutter.dev/flutter/iOS/",
  "https://api.flutter.dev/flutter/Linux/",
  "https://api.flutter.dev/flutter/macOS/",
  "https://api.flutter.dev/flutter/Windows/",
  "https://api.flutter.dev/flutter/flutter_test/",
  "https://api.flutter.dev/flutter/flutter_driver_extension/",
  "https://api.flutter.dev/flutter/flutter_driver/",
  "https://api.flutter.dev/flutter/flutter_gpu/",
  "https://api.flutter.dev/flutter/flutter_localizations/",
  "https://api.flutter.dev/flutter/flutter_web_plugins/",
  "https://api.flutter.dev/flutter/package-flutter_web_plugins_url_strategy/",
  "https://api.flutter.dev/flutter/package-leak_tracker_flutter_testing_leak_tracker_flutter_testing/",
  "https://api.flutter.dev/flutter/package-async_async/",
  "https://api.flutter.dev/flutter/package-boolean_selector_boolean_selector/",
  "https://api.flutter.dev/flutter/package-characters_characters/",
  "https://api.flutter.dev/flutter/package-clock_clock/",
  "https://api.flutter.dev/flutter/package-collection_algorithms/",
  "https://api.flutter.dev/flutter/package-collection_collection/",
  "https://api.flutter.dev/flutter/package-collection_equality/",
  "https://api.flutter.dev/flutter/package-collection_iterable_zip/",
  "https://api.flutter.dev/flutter/package-collection_priority_queue/",
  "https://api.flutter.dev/flutter/package-collection_wrappers/",
  "https://api.flutter.dev/flutter/package-crypto_crypto/",
  "https://api.flutter.dev/flutter/package-fake_async_fake_async/",
  "https://api.flutter.dev/flutter/package-file_chroot/",
  "https://api.flutter.dev/flutter/package-file_file/",
  "https://api.flutter.dev/flutter/package-file_local/",
  "https://api.flutter.dev/flutter/package-file_memory/",
  "https://api.flutter.dev/flutter/package-integration_test_common/",
  "https://api.flutter.dev/flutter/package-integration_test_integration_test/",
  "https://api.flutter.dev/flutter/package-integration_test_integration_test_driver/",
  "https://api.flutter.dev/flutter/package-integration_test_integration_test_driver_extended/",
  "https://api.flutter.dev/flutter/package-intl_date_symbol_data_custom/",
  "https://api.flutter.dev/flutter/package-intl_date_symbol_data_file/",
  "https://api.flutter.dev/flutter/package-intl_date_symbol_data_http_request/",
  "https://api.flutter.dev/flutter/package-intl_date_symbol_data_local/",
  "https://api.flutter.dev/flutter/package-intl_date_symbols/",
  "https://api.flutter.dev/flutter/package-intl_date_time_patterns/",
  "https://api.flutter.dev/flutter/package-intl_find_locale/",
  "https://api.flutter.dev/flutter/package-intl_intl/",
  "https://api.flutter.dev/flutter/package-intl_intl_default/",
  "https://api.flutter.dev/flutter/package-intl_intl_standalone/",
  "https://api.flutter.dev/flutter/package-intl_locale/",
  "https://api.flutter.dev/flutter/package-intl_message_format/",
  "https://api.flutter.dev/flutter/package-intl_message_lookup_by_library/",
  "https://api.flutter.dev/flutter/package-intl_number_symbols/",
  "https://api.flutter.dev/flutter/package-intl_number_symbols_data/",
  "https://api.flutter.dev/flutter/package-leak_tracker_leak_tracker/",
  "https://api.flutter.dev/flutter/package-leak_tracker_testing_leak_tracker_testing/",
  "https://api.flutter.dev/flutter/package-matcher_expect/",
  "https://api.flutter.dev/flutter/package-matcher_matcher/",
  "https://api.flutter.dev/flutter/package-material_color_utilities_blend_blend/",
  "https://api.flutter.dev/flutter/package-material_color_utilities_contrast_contrast/",
  "https://api.flutter.dev/flutter/package-material_color_utilities_dislike_dislike_analyzer/",
  "https://api.flutter.dev/flutter/package-material_color_utilities_dynamiccolor_dynamic_color/",
  "https://api.flutter.dev/flutter/package-material_color_utilities_dynamiccolor_dynamic_scheme/",
  "https://api.flutter.dev/flutter/package-material_color_utilities_dynamiccolor_material_dynamic_colors/",
  "https://api.flutter.dev/flutter/package-material_color_utilities_dynamiccolor_src_contrast_curve/",
  "https://api.flutter.dev/flutter/package-material_color_utilities_dynamiccolor_src_tone_delta_pair/",
  "https://api.flutter.dev/flutter/package-material_color_utilities_dynamiccolor_variant/",
  "https://api.flutter.dev/flutter/package-material_color_utilities_hct_cam16/",
  "https://api.flutter.dev/flutter/package-material_color_utilities_hct_hct/",
  "https://api.flutter.dev/flutter/package-material_color_utilities_hct_src_hct_solver/",
  "https://api.flutter.dev/flutter/package-material_color_utilities_hct_viewing_conditions/",
  "https://api.flutter.dev/flutter/package-material_color_utilities_material_color_utilities/",
  "https://api.flutter.dev/flutter/package-material_color_utilities_palettes_core_palette/",
  "https://api.flutter.dev/flutter/package-material_color_utilities_palettes_core_palettes/",
  "https://api.flutter.dev/flutter/package-material_color_utilities_palettes_tonal_palette/",
  "https://api.flutter.dev/flutter/package-material_color_utilities_quantize_quantizer/",
  "https://api.flutter.dev/flutter/package-material_color_utilities_quantize_quantizer_celebi/",
  "https://api.flutter.dev/flutter/package-material_color_utilities_quantize_quantizer_map/",
  "https://api.flutter.dev/flutter/package-material_color_utilities_quantize_quantizer_wsmeans/",
  "https://api.flutter.dev/flutter/package-material_color_utilities_quantize_quantizer_wu/",
  "https://api.flutter.dev/flutter/package-material_color_utilities_quantize_src_point_provider/",
  "https://api.flutter.dev/flutter/package-material_color_utilities_quantize_src_point_provider_lab/",
  "https://api.flutter.dev/flutter/package-material_color_utilities_scheme_scheme/",
  "https://api.flutter.dev/flutter/package-material_color_utilities_scheme_scheme_content/",
  "https://api.flutter.dev/flutter/package-material_color_utilities_scheme_scheme_expressive/",
  "https://api.flutter.dev/flutter/package-material_color_utilities_scheme_scheme_fidelity/",
  "https://api.flutter.dev/flutter/package-material_color_utilities_scheme_scheme_fruit_salad/",
  "https://api.flutter.dev/flutter/package-material_color_utilities_scheme_scheme_monochrome/",
  "https://api.flutter.dev/flutter/package-material_color_utilities_scheme_scheme_neutral/",
  "https://api.flutter.dev/flutter/package-material_color_utilities_scheme_scheme_rainbow/",
  "https://api.flutter.dev/flutter/package-material_color_utilities_scheme_scheme_tonal_spot/",
  "https://api.flutter.dev/flutter/package-material_color_utilities_scheme_scheme_vibrant/",
  "https://api.flutter.dev/flutter/package-material_color_utilities_score_score/",
  "https://api.flutter.dev/flutter/package-material_color_utilities_temperature_temperature_cache/",
  "https://api.flutter.dev/flutter/package-material_color_utilities_utils_color_utils/",
  "https://api.flutter.dev/flutter/package-material_color_utilities_utils_math_utils/",
  "https://api.flutter.dev/flutter/package-material_color_utilities_utils_string_utils/",
  "https://api.flutter.dev/flutter/meta_dart2js/",
  "https://api.flutter.dev/flutter/meta/",
  "https://api.flutter.dev/flutter/meta_meta/",
  "https://api.flutter.dev/flutter/package-path_path/",
  "https://api.flutter.dev/flutter/package-platform_platform/",
  "https://api.flutter.dev/flutter/package-process_process/",
  "https://api.flutter.dev/flutter/package-source_span_source_span/",
  "https://api.flutter.dev/flutter/package-stack_trace_stack_trace/",
  "https://api.flutter.dev/flutter/package-stream_channel_isolate_channel/",
  "https://api.flutter.dev/flutter/package-stream_channel_stream_channel/",
  "https://api.flutter.dev/flutter/package-string_scanner_string_scanner/",
  "https://api.flutter.dev/flutter/sync.http/",
  "https://api.flutter.dev/flutter/package-term_glyph_term_glyph/",
  "https://api.flutter.dev/flutter/package-test_api_backend/",
  "https://api.flutter.dev/flutter/package-test_api_fake/",
  "https://api.flutter.dev/flutter/package-test_api_hooks/",
  "https://api.flutter.dev/flutter/package-test_api_hooks_testing/",
  "https://api.flutter.dev/flutter/package-test_api_scaffolding/",
  "https://api.flutter.dev/flutter/package-test_api_test_api/",
  "https://api.flutter.dev/flutter/package-typed_data_typed_buffers/",
  "https://api.flutter.dev/flutter/package-typed_data_typed_data/",
  "https://api.flutter.dev/flutter/package-vector_math_hash/",
  "https://api.flutter.dev/flutter/package-vector_math_vector_math/",
  "https://api.flutter.dev/flutter/package-vector_math_vector_math_64/",
  "https://api.flutter.dev/flutter/package-vector_math_vector_math_geometry/",
  "https://api.flutter.dev/flutter/package-vector_math_vector_math_lists/",
  "https://api.flutter.dev/flutter/package-vector_math_vector_math_operations/",
  "https://api.flutter.dev/flutter/package-vm_service_utils/",
  "https://api.flutter.dev/flutter/vm_service/",
  "https://api.flutter.dev/flutter/package-vm_service_vm_service_io/",
  "https://api.flutter.dev/flutter/package-webdriver_async_core/",
  "https://api.flutter.dev/flutter/package-webdriver_async_html/",
  "https://api.flutter.dev/flutter/package-webdriver_async_io/",
  "https://api.flutter.dev/flutter/core/",
  "https://api.flutter.dev/flutter/io/",
  "https://api.flutter.dev/flutter/package-webdriver_support_async/",
  "https://api.flutter.dev/flutter/package-webdriver_support_firefox_profile/",
  "https://api.flutter.dev/flutter/package-webdriver_support_stdio_stepper/",
  "https://api.flutter.dev/flutter/package-webdriver_sync_core/",
  "https://api.flutter.dev/flutter/package-webdriver_sync_io/"
];

(() => {

  const normalizeUrl = url => url.replace("https://api.flutter.dev/flutter/widgets/", "").replace(/\.html$/g, "");

  const getUrlIdentifier = () => {
    return normalizeUrl(location.href);
  };

  const Storer = class {
    save(data) {
      const currentJson = localStorage.dartapi;
      let currentData = {};
      try {
        currentData = JSON.parse(currentJson);
      } catch (error) {

      }
      currentData[getUrlIdentifier()] = data;
      localStorage.dartapi = JSON.stringify(currentData);
      this.onSaved(currentData)
      return currentData;
    }
    load() {
      return JSON.parse(localStorage.dartapi);
    }
    onSaved(currentData) {
      const targets = window.ScrapTargets;
      Iterating_targets:
      for (let index = 0; index < targets.length; index++) {
        const target = targets[index];
        const normalizedUrl = normalizeUrl(target);
        if(!(normalizedUrl in currentData)) {
          console.log("[OK] Ya pillada siguiente página:", normalizeUrl);
          setTimeout(() => {
            window.location.href = target;
          }, 5000);
          break Iterating_targets;
        } else {
          continue Iterating_targets;
        }
      }
    }
  }
  window.ScrapSaver = new Storer();

})();

data = (() => {

  // let Find, Find1, Ensure, section$el;

  const Output = {};
  const Find = (sel, base = document.body) => base.querySelectorAll(sel);
  const FindOne = (...args) => {
    Find(...args)[0];
  };
  const Ensure = (condition, message) => {
    if (!condition) throw new Error(message);
  };
  const Foreach = (list, callback) => {
    for (let i = 0; i < list.length; i++) {
      callback(list[i], i, list);
    }
  };
  const NormalizeText = (text) => {
    return text.replace(/[\r\t\n ]+/g, " ").trim();
  };

  const Elem$sections = Find("section");
  Ensure(Elem$sections.length !== 0, "Debería tener secciones (1)");
  Foreach(Elem$sections, (Elem$section, indexSection) => {
    const Elem$sectionTitles = Find("h2", Elem$section);
    const hasTitle = Elem$sectionTitles.length !== 0;
    let sectionTitle = "unknown section";
    if (hasTitle) {
      const Elem$sectionTitle = Elem$sectionTitles[0];
      sectionTitle = NormalizeText(Elem$sectionTitle.textContent);
    }
    const knowsSection = sectionTitle in Output;
    if (!knowsSection) {
      Output[sectionTitle] = [];
    }
    const Elem$details = Find("dl", Elem$section);
    Foreach(Elem$details, (Elem$detail, indexDetail) => {
      const Elem$detailTitles = Elem$detail.querySelectorAll("dt");
      Foreach(Elem$detailTitles, (Elem$detailTitle, indexDetailTitle) => {
        const Elem$detailDescription = Elem$detailTitle.nextElementSibling;
        Output[sectionTitle].push({
          title: NormalizeText(Elem$detailTitle.textContent),
          description: NormalizeText(Elem$detailDescription.textContent),
        });
      });
    })
  });

  window.ScrapSaver.save(Output);

})();
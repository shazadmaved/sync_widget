part of pdf;

/// Represents PDF form's submit action.submit action allows submission of data
/// that is entered in the PDF form
class PdfSubmitAction extends PdfFormAction {
  //Constructor
  /// Initializes a new instance of the [PdfSubmitAction] class with
  /// URL to submit the form data
  PdfSubmitAction(String url,
      {HttpMethod httpMethod = HttpMethod.post,
      SubmitDataFormat dataFormat = SubmitDataFormat.fdf,
      bool canonicalDateTimeFormat = false,
      bool submitCoordinates = false,
      bool includeNoValueFields = false,
      bool includeIncrementalUpdates = false,
      bool includeAnnotations = false,
      bool excludeNonUserAnnotations = false,
      bool embedForm = false,
      bool include = false,
      List<PdfField>? fields})
      : super._() {
    if (url.isEmpty) {
      ArgumentError.value('The URL can\'t be an empty string.');
    }
    _url = url;
    _dictionary.setProperty(_DictionaryProperties.f, _PdfString(_url));
    _initValues(
        httpMethod = HttpMethod.post,
        dataFormat,
        canonicalDateTimeFormat,
        submitCoordinates,
        includeNoValueFields,
        includeIncrementalUpdates,
        includeAnnotations,
        excludeNonUserAnnotations,
        embedForm,
        include,
        fields);
  }

  //Fields
  String _url = '';
  HttpMethod _httpMethod = HttpMethod.post;
  SubmitDataFormat _dataFormat = SubmitDataFormat.fdf;
  List<PdfSubmitFormFlags> _flags = <PdfSubmitFormFlags>[];
  bool _canonicalDateTimeFormat = false;
  bool _submitCoordinates = false;
  bool _includeNoValueFields = false;
  bool _includeIncrementalUpdates = false;
  bool _includeAnnotations = false;
  bool _excludeNonUserAnnotations = false;
  bool _embedForm = false;

  //Properties
  /// Gets an Url address where the data should be transferred.
  String get url => _url;

  /// Gets or sets the [SubmitDataFormat].
  SubmitDataFormat get dataFormat => _dataFormat;
  set dataFormat(SubmitDataFormat value) {
    if (_dataFormat != value) {
      _dataFormat = value;
      switch (_dataFormat) {
        case SubmitDataFormat.pdf:
          _flags.add(PdfSubmitFormFlags.submitPdf);
          break;
        case SubmitDataFormat.xfdf:
          _flags.add(PdfSubmitFormFlags.xfdf);
          break;
        case SubmitDataFormat.html:
          _flags.add(PdfSubmitFormFlags.exportFormat);
          break;
        case SubmitDataFormat.fdf:
          break;
      }
    }
  }

  /// Gets or sets the HTTP method.
  HttpMethod get httpMethod => _httpMethod;
  set httpMethod(HttpMethod value) {
    if (_httpMethod != value) {
      _httpMethod = value;
      if (_httpMethod == HttpMethod.getHttp) {
        _flags.add(PdfSubmitFormFlags.getMethod);
      } else {
        _flags.remove(PdfSubmitFormFlags.getMethod);
      }
    }
  }

  /// If set, any submitted field values representing dates are converted to
  /// the standard format.
  bool get canonicalDateTimeFormat => _canonicalDateTimeFormat;
  set canonicalDateTimeFormat(bool value) {
    if (_canonicalDateTimeFormat != value) {
      _canonicalDateTimeFormat = value;

      if (_canonicalDateTimeFormat) {
        _flags.add(PdfSubmitFormFlags.canonicalFormat);
      } else {
        _flags.remove(PdfSubmitFormFlags.canonicalFormat);
      }
    }
  }

  /// Gets or sets a value indicating whether to submit mouse pointer coordinates.
  bool get submitCoordinates => _submitCoordinates;
  set submitCoordinates(bool value) {
    if (_submitCoordinates != value) {
      _submitCoordinates = value;

      if (_submitCoordinates) {
        _flags.add(PdfSubmitFormFlags.submitCoordinates);
      } else {
        _flags.remove(PdfSubmitFormFlags.submitCoordinates);
      }
    }
  }

  /// Gets or sets a value indicating whether to submit fields without value.
  bool get includeNoValueFields => _includeNoValueFields;
  set includeNoValueFields(bool value) {
    if (_includeNoValueFields != value) {
      _includeNoValueFields = value;

      if (_includeNoValueFields) {
        _flags.add(PdfSubmitFormFlags.includeNoValueFields);
      } else {
        _flags.remove(PdfSubmitFormFlags.includeNoValueFields);
      }
    }
  }

  /// Gets or sets a value indicating whether to submit
  /// form's incremental updates.
  bool get includeIncrementalUpdates => _includeIncrementalUpdates;
  set includeIncrementalUpdates(bool value) {
    if (_includeIncrementalUpdates != value) {
      _includeIncrementalUpdates = value;

      if (_includeIncrementalUpdates) {
        _flags.add(PdfSubmitFormFlags.includeAppendSaves);
      } else {
        _flags.remove(PdfSubmitFormFlags.includeAppendSaves);
      }
    }
  }

  /// Gets or sets a value indicating whether to submit annotations.
  bool get includeAnnotations => _includeAnnotations;
  set includeAnnotations(bool value) {
    if (_includeAnnotations != value) {
      _includeAnnotations = value;

      if (_includeAnnotations) {
        _flags.add(PdfSubmitFormFlags.includeAnnotations);
      } else {
        _flags.remove(PdfSubmitFormFlags.includeAnnotations);
      }
    }
  }

  /// Gets or sets a value indicating whether to exclude non user annotations
  /// form submit data stream.
  bool get excludeNonUserAnnotations => _excludeNonUserAnnotations;
  set excludeNonUserAnnotations(bool value) {
    if (_excludeNonUserAnnotations != value) {
      _excludeNonUserAnnotations = value;

      if (_excludeNonUserAnnotations) {
        _flags.add(PdfSubmitFormFlags.exclNonUserAnnots);
      } else {
        _flags.remove(PdfSubmitFormFlags.exclNonUserAnnots);
      }
    }
  }

  /// Gets or sets a value indicating whether to include form
  /// to submit data stream.
  bool get embedForm => _embedForm;
  set embedForm(bool value) {
    if (_embedForm != value) {
      _embedForm = value;
      if (_embedForm) {
        _flags.add(PdfSubmitFormFlags.embedForm);
      } else {
        _flags.remove(PdfSubmitFormFlags.embedForm);
      }
    }
  }

  @override
  bool get include => super.include;
  set include(bool value) {
    if (super.include != value) {
      super.include = value;
      if (super.include) {
        _flags.remove(PdfSubmitFormFlags.includeExclude);
      } else {
        _flags.add(PdfSubmitFormFlags.includeExclude);
      }
    }
  }

  //Implementation
  @override
  void _initialize() {
    super._initialize();
    _dictionary._beginSave = _dictionaryBeginSave;
    _dictionary.setProperty(
        _DictionaryProperties.s, _PdfName(_DictionaryProperties.submitForm));
  }

  void _dictionaryBeginSave(Object sender, _SavePdfPrimitiveArgs? ars) {
    _dictionary.setProperty(
        _DictionaryProperties.flags, _PdfNumber(_getFlagValue(_flags)));
  }

  void _initValues(
      HttpMethod http,
      SubmitDataFormat format,
      bool canonicalDateTime,
      bool submit,
      bool includeNoValue,
      bool includeIncremental,
      bool includeAnnot,
      bool excludeNonUserAnnot,
      bool embed,
      bool initInclude,
      List<PdfField>? field) {
    httpMethod = http;
    dataFormat = format;
    canonicalDateTimeFormat = canonicalDateTime;
    submitCoordinates = submit;
    includeNoValueFields = includeNoValue;
    includeIncrementalUpdates = includeIncremental;
    includeAnnotations = includeAnnot;
    excludeNonUserAnnotations = excludeNonUserAnnot;
    embedForm = embed;
    include = initInclude;
    if (field != null) {
      field.forEach((f) => fields.add(f));
    }
  }

  int _getFlagValue(List<PdfSubmitFormFlags> sumbitFlags) {
    int result = 0;
    for (final PdfSubmitFormFlags sumbitFlag in sumbitFlags) {
      switch (sumbitFlag) {
        case PdfSubmitFormFlags.includeExclude:
          result = result + 1;
          break;
        case PdfSubmitFormFlags.includeNoValueFields:
          result = result + 2;
          break;
        case PdfSubmitFormFlags.exportFormat:
          result = result + 4;
          break;
        case PdfSubmitFormFlags.getMethod:
          result = result + 8;
          break;
        case PdfSubmitFormFlags.submitCoordinates:
          result = result + 16;
          break;
        case PdfSubmitFormFlags.xfdf:
          result = result + 32;
          break;
        case PdfSubmitFormFlags.includeAppendSaves:
          result = result + 64;
          break;
        case PdfSubmitFormFlags.includeAnnotations:
          result = result + 128;
          break;
        case PdfSubmitFormFlags.submitPdf:
          result = result + 256;
          break;
        case PdfSubmitFormFlags.canonicalFormat:
          result = result + 512;
          break;
        case PdfSubmitFormFlags.exclNonUserAnnots:
          result = result + 1024;
          break;
        case PdfSubmitFormFlags.exclFKey:
          result = result + 2048;
          break;
        case PdfSubmitFormFlags.embedForm:
          result = result + 4096;
          break;
      }
    }
    return result;
  }
}

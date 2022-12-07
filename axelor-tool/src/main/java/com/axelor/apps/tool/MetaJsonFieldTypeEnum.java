package com.axelor.apps.tool;

import java.util.Arrays;

/**
 * List the expected values in the field {@link com.axelor.meta.db.MetaJsonField#type}, i.e. the
 * ones provided by Axelor Open Platform selection <i>json.field.type</i>.
 */
public enum MetaJsonFieldTypeEnum {
  STRING("string"),
  INTEGER("integer"),
  LONG("long"),
  DECIMAL("decimal"),
  BOOLEAN("boolean"),
  DATETIME("datetime"),
  DATE("date"),
  TIME("time"),

  MANY_TO_MANY("many-to-many"),
  ONE_TO_MANY("one-to-many"),
  MANY_TO_ONE("many-to-one"),
  ONE_TO_ONE("one-to-one"),

  JSON_MANY_TO_ONE("json-many-to-one"),
  JSON_MANY_TO_MANY("json-many-to-many"),
  JSON_ONE_TO_MANY("json-one-to-many"),

  PANEL("panel"),
  ENUM("enum"),
  BUTTON("button"),
  SEPARATOR("separator");

  String value;

  MetaJsonFieldTypeEnum(String value) {
    this.value = value;
  }

  public String getValue() {
    return value;
  }

  public static MetaJsonFieldTypeEnum valueOfByValue(String value) throws IllegalArgumentException {
    return Arrays.stream(values())
        .filter(v -> value.equals(v.getValue()))
        .findAny()
        .orElseThrow(() -> new IllegalArgumentException("The value " + value + " doesn't exist."));
  }
}

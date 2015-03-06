#Squisher Choosing
DHO_VENDOR := vanir

# Tablet Overlays no radios
    PRODUCT_PACKAGE_OVERLAYS += vendor/vanir/overlay/tab_no_radio

# Boot Animation
PRODUCT_COPY_FILES += \
    vendor/vanir/proprietary/boot_animations/480x800.zip:system/media/bootanimation.zip

# Inherit device configuration for bowser
$(call inherit-product, device/amazon/tate/full_tate.mk)
$(call inherit-product, device/amazon/bowser-common/cm.mk)

# Inherit common product files.
$(call inherit-product, vendor/vanir/products/common_tabs.mk)

#TARGET_SCREEN_WIDTH := 1280
TARGET_SCREEN_WIDTH := 480
TARGET_SCREEN_HEIGHT := 800

PRODUCT_NAME := vanir_tate
PRODUCT_RELEASE_NAME := KindleFireHD


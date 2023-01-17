# syntax=docker/dockerfile:1.3

ARG ERPNEXT_VERSION
FROM frappe/erpnext-worker:v13

USER root

# Copy swiss accounting plans
COPY repos/ERPNext_ch_kmu/. ../apps/erpnext/erpnext/accounts/doctype/account/chart_of_accounts/verified

# Copy and install custom apps
COPY repos ../apps
RUN install-app erpnextswiss

USER frappe

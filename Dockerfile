FROM python:3.7-slim

ARG USER_ID=1001
ARG GROUP_ID=1001

RUN groupadd -g $GROUP_ID frappe && \
    useradd -m -u $USER_ID -g $GROUP_ID -s /bin/bash frappe
USER frappe
ENV HOME /home/frappe
ENV PATH $PATH:$HOME/.local/bin

RUN mkdir /home/frappe/agent && \
  mkdir /home/frappe/repo && \
  chown -R frappe:frappe /home/frappe

COPY --chown=frappe:frappe requirements.txt /home/frappe/repo/
RUN pip install --user --requirement /home/frappe/repo/requirements.txt

COPY --chown=frappe:frappe . /home/frappe/repo/
RUN pip install --user --editable /home/frappe/repo

WORKDIR /home/frappe/agent

ARG USERNAME

FROM python:3.8

ARG USERNAME

# Create a non-root user
RUN groupadd ${USERNAME} --gid 1000 \
    && useradd ${USERNAME} --create-home --shell /bin/bash --uid 1000 --gid 1000

ENV PATH=/home/${USERNAME}/.local/bin:$PATH

RUN chown -R ${USERNAME}:${USERNAME} /usr/local

USER ${USERNAME}

# Upgrade pip version
RUN pip install --upgrade pip

# Install poetry
RUN pip install poetry --user

# Set poetry configuration
RUN poetry config virtualenvs.create false \
    && poetry config virtualenvs.in-project false

ENTRYPOINT [ "/bin/bash" ]
